//
//  MainScreen.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
import ZenID

struct MainScreen: View, IdentifiableScreen {

    @State var serverTitle: String = "None"
    @State var profile: String = "Default"
    @State var country: String = "Cz"
    @State var role: String?
    @State var page: String?
    @State var enabledVerifiers: Set<SdkVerifierType> = []
    @State var isInitializing: Bool = false
    @State var lastAuthorizationTime: Date?

    // Mapping of verifier types to their UI representations
    struct VerifierOption {
        let type: SdkVerifierType
        let title: String
        let systemImage: String
        let screen: Screen
    }

    let allVerifierOptions: [VerifierOption] = [
        VerifierOption(type: .document, title: "Document scanning", systemImage: "person.text.rectangle", screen: .documentScanner),
        VerifierOption(type: .hologram, title: "Hologram checking", systemImage: "creditcard.trianglebadge.exclamationmark", screen: .hologramCheck),
        VerifierOption(type: .faceLiveness, title: "Faceliveness", systemImage: "person.and.arrow.left.and.arrow.right.outward", screen: .facelivenessCheck),
        VerifierOption(type: .selfie, title: "Selfie", systemImage: "person", screen: .selfieCheck),
        VerifierOption(type: .msLiveness, title: "MS Liveness", systemImage: "eye", screen: .msLivenessCheck),
        VerifierOption(type: .licensePlate, title: "Licence plate", systemImage: "car.front.waves.down", screen: .licencePlateCheck)
    ]

    var body: some View {
        ZStack {
            List {
                Section {
                    OptionRow(title: "Server", value: serverTitle, systemImage: "qrcode.viewfinder", screen: .login)
                        .onAppear {
                            serverTitle = Credentials.load(key: storageCredentials)?.url.host ?? "Select server"
                        }
                    OptionRow(title: "Profile", value: profile, systemImage: "document.badge.gearshape", screen: .profile)
                        .onAppear {
                            let currentProfile = Profile.current
                            profile = currentProfile == "" ? "Default" : currentProfile
                        }
                }
                Section(header: Text("Document scanner settings")) {
                    OptionRow(title: "Country",
                              value: country,
                              systemImage: "globe.americas.fill",
                              screen: .pickCountry)
                    OptionRow(title: "Role",
                              value: role,
                              systemImage: "questionmark.text.page",
                              screen: .pickRole)
                    OptionRow(title: "Page",
                              value: page,
                              systemImage: "book.pages",
                              screen: .pickPage)
                }
                Section(header: Text("Verifiers"), footer: Text("version \(String.appVersion)")) {
                    ForEach(allVerifierOptions.filter { enabledVerifiers.contains($0.type) }, id: \.type) { option in
                        OptionRow(title: option.title,
                                  systemImage: option.systemImage,
                                  screen: option.screen)
                    }
                }
            }
            .navigationTitle("ZenID Sample")
            .disabled(isInitializing)

            if isInitializing {
                WaitView(title: "Initializing...", icon: "gearshape", rotate: true)
            }
        }
        .onAppear {
            OSLogger.app.info("MainScreen.onAppear")

            // Reload server info
            serverTitle = Credentials.load(key: storageCredentials)?.url.host ?? "Select server"

            // Reload profile
            let currentProfile = Profile.current
            profile = currentProfile.isEmpty ? "Default" : currentProfile

            // Reload document configuration
            let config = DocumentConfiguration.load(key: storageConfiguration, defaultValue: DocumentConfiguration(country: .cz))!
            country = "\(config.country)"
            role = config.role == nil ? "None" : "\(config.role!)"
            page = config.page == nil ? "None" : "\(config.page!)"
        }
        .task {
            // Initialize or reauthorize SDK if credentials exist
            if let credentials = Credentials.load(key: storageCredentials) {
                let now = Date()
                let shouldReauthorize: Bool

                if let lastAuth = lastAuthorizationTime {
                    let timeSinceLastAuth = now.timeIntervalSince(lastAuth)
                    shouldReauthorize = timeSinceLastAuth >= 300 // 5 minutes in seconds
                } else {
                    shouldReauthorize = true
                }

                if shouldReauthorize {
                    isInitializing = true

                    if ZenIDManager.isAuthorized() {
                        _ = await ZenIDManager.reauthorize()
                        OSLogger.app.info("Reauthorization completed")
                        lastAuthorizationTime = now
                    } else {
                        do {
                            let backendApi = ZenIDBackendApiImpl(baseURL: credentials.url, apiKey: credentials.key)
                            try await ZenIDManager.initialize(backendApi: backendApi)
                            OSLogger.app.info("Authorization completed successfully")
                            lastAuthorizationTime = now
                        } catch {
                            OSLogger.app.error("Authorization failed: \(error)")
                        }
                    }

                    isInitializing = false
                } else {
                    OSLogger.app.info("Skipping reauthorization, last authorization was less than 5 minutes ago")
                }
            } else {
                OSLogger.app.info("No credentials found, skipping authorization")
            }

            // Validate and reload configuration
            await validateAndReloadConfiguration()
        }
    }

    private func showAllVerifiers() {
        enabledVerifiers = Set(allVerifierOptions.map { $0.type })
    }

    private func validateAndReloadConfiguration() async {
        guard ZenIDManager.isAuthorized() else {
            OSLogger.app.info("SDK not authorized, skipping configuration validation")
            return
        }
        
        let verifiers = ZenIDManager.getEnabledVerifiers()
        enabledVerifiers = Set(verifiers)
        print("Loaded enabled verifiers: \(verifiers)")

        var config = DocumentConfiguration.load(key: storageConfiguration, defaultValue: DocumentConfiguration(country: .cz))!
        var configChanged = false
     
        // Validate and reload profile
        if let profilesData = try? await ZenIDManager.getProfiles(),
           let profilesResponse = try? ZenIDManager.decode(profilesData, as: ProfilesResponse.self) {
            let availableProfiles = profilesResponse.results ?? []
            let currentProfile = Profile.current

            if !currentProfile.isEmpty && !availableProfiles.contains(currentProfile) {
                // Current profile not available, reset to default
                Profile.current = ""
                profile = "Default"
                ZenIDManager.selectProfile("")
                OSLogger.app.info("Profile '\(currentProfile)' not available, reset to default")
            } else {
                profile = currentProfile.isEmpty ? "Default" : currentProfile
            }
        }

        // Validate and reload country
        if let supportedCountries = ZenIDManager.supportedCountries() {
            if !supportedCountries.contains(config.country) {
                // Current country not available, reset to first available or .cz
                config.country = supportedCountries.first ?? .cz
                configChanged = true
                OSLogger.app.info("Country not available, reset to \(config.country)")
            }
            country = "\(config.country)"
        }

        // Validate and reload role
        if let supportedDocuments = ZenIDManager.supportedDocuments(for: config.country) {
            if let currentRole = config.role, !supportedDocuments.contains(currentRole) {
                // Current role not available for this country, reset to nil
                config.role = nil
                config.page = nil
                configChanged = true
                OSLogger.app.info("Role '\(currentRole)' not available for country \(config.country), reset to None")
            }
            role = config.role == nil ? "None" : "\(config.role!)"
        }

        // Validate and reload page
        if let currentRole = config.role,
           let supportedPages = ZenIDManager.supportedDocumentPageCodes(for: config.country, documentRole: currentRole) {
            if let currentPage = config.page, !supportedPages.contains(currentPage) {
                // Current page not available for this role, reset to first available
                config.page = supportedPages.sorted(by: { $0.rawValue < $1.rawValue }).first
                configChanged = true
                OSLogger.app.info("Page '\(currentPage)' not available for role \(currentRole), reset to \(config.page?.rawValue ?? 0)")
            }
            page = config.page == nil ? "None" : "\(config.page!)"
        } else {
            page = config.page == nil ? "None" : "\(config.page!)"
        }

        // Save configuration if changed
        if configChanged {
            do {
                try config.save(key: storageConfiguration)
                OSLogger.app.info("Configuration validated and saved")
            } catch {
                OSLogger.app.error("Failed to save configuration: \(error)")
            }
        }
    }
}

#Preview {
    MainScreen()
}
