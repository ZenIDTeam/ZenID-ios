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
    @State var authorizationError: String?
    @AppStorage(storageCustomData) var customData: String = ""

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
                    // Stored on the SDK session at initSdk, so a new value needs a new authorization.
                    HStack {
                        Label("CustomData", systemImage: "person.text.rectangle")
                        TextField("None", text: $customData)
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled()
                            .onSubmit { Task { await authorize(force: true) } }
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
            let config = DocumentConfiguration.load(key: storageConfiguration, defaultValue: DocumentConfiguration())!
            country = config.country.map { "\($0)" } ?? "Any"
            role = config.role == nil ? "None" : "\(config.role!)"
            page = config.page == nil ? "None" : "\(config.page!)"
        }
        .task {
            await authorize()

            // Validate and reload configuration
            await validateAndReloadConfiguration()
        }
        .alert(String(localized: "error-authorization-failed-title"), isPresented: Binding(
            get: { authorizationError != nil },
            set: { _ in }
        )) {
            Button("OK", role: .cancel) {
                authorizationError = nil
            }
        } message: {
            if let error = authorizationError {
                Text(error)
            }
        }
    }

    private func showAllVerifiers() {
        enabledVerifiers = Set(allVerifierOptions.map { $0.type })
    }

    /// Initialize or reauthorize the SDK if credentials exist; `force` runs a full initialize even when authorized.
    private func authorize(force: Bool = false) async {
        guard let credentials = Credentials.load(key: storageCredentials) else {
            OSLogger.app.info("No credentials found, skipping authorization")
            return
        }
        let now = Date()
        if !force, let lastAuth = lastAuthorizationTime, now.timeIntervalSince(lastAuth) < 300 {
            OSLogger.app.info("Skipping reauthorization, last authorization was less than 5 minutes ago")
            return
        }

        isInitializing = true
        if ZenIDManager.isAuthorized() && !force {
            _ = await ZenIDManager.reauthorize()
            OSLogger.app.info("Reauthorization completed")
            lastAuthorizationTime = now
        } else {
            do {
                let backendApi = ZenIDBackendApiImpl(baseURL: credentials.url, apiKey: credentials.key)
                try await ZenIDManager.initialize(backendApi: backendApi, customData: customData.isEmpty ? nil : customData)
                OSLogger.app.info("Authorization completed successfully")
                lastAuthorizationTime = now
            } catch {
                OSLogger.app.error("Authorization failed: \(error)")
                authorizationError = String(localized: "error-authorization-failed-message")
                Haptics.shared.playError()
            }
        }
        isInitializing = false
    }

    private func validateAndReloadConfiguration() async {
        guard ZenIDManager.isAuthorized() else {
            OSLogger.app.info("SDK not authorized, skipping configuration validation")
            return
        }

        let verifiers = ZenIDManager.getEnabledVerifiers()
        enabledVerifiers = Set(verifiers)
        print("Loaded enabled verifiers: \(verifiers)")

        var config = DocumentConfiguration.load(key: storageConfiguration, defaultValue: DocumentConfiguration())!
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
        if let selectedCountry = config.country {
            // A specific country is selected - validate it
            if let supportedCountries = ZenIDManager.supportedCountries() {
                if !supportedCountries.contains(selectedCountry) {
                    // Current country not available, reset to nil (Any)
                    config.country = nil
                    configChanged = true
                    OSLogger.app.info("Country \(selectedCountry) not available, reset to Any")
                }
            }
        }
        // nil country (Any) is always valid
        country = config.country.map { "\($0)" } ?? "Any"

        // Validate and reload role
        if let currentRole = config.role {
            if let selectedCountry = config.country {
                // Specific country: validate role is available for that country
                if let supportedDocuments = ZenIDManager.supportedDocuments(for: selectedCountry) {
                    if !supportedDocuments.contains(currentRole) {
                        config.role = nil
                        config.page = nil
                        configChanged = true
                        OSLogger.app.info("Role '\(currentRole)' not available for country \(selectedCountry), reset to None")
                    }
                }
            } else {
                // "Any" country: validate role is available in at least one country
                let roleAvailable = ZenIDManager.supportedDocuments(for: nil)?.contains(currentRole) ?? false
                if !roleAvailable {
                    config.role = nil
                    config.page = nil
                    configChanged = true
                    OSLogger.app.info("Role '\(currentRole)' not available for any country, reset to None")
                }
            }
        }
        role = config.role == nil ? "None" : "\(config.role!)"

        // Validate and reload page
        if let currentRole = config.role {
            if let currentPage = config.page {
                if let selectedCountry = config.country {
                    // Specific country
                    if let supportedPages = ZenIDManager.supportedDocumentPageCodes(for: selectedCountry, documentRole: currentRole) {
                        if !supportedPages.contains(currentPage) {
                            config.page = supportedPages.sorted(by: { $0.rawValue < $1.rawValue }).first
                            configChanged = true
                            OSLogger.app.info("Page '\(currentPage)' not available for role \(currentRole), reset to \(config.page?.rawValue ?? 0)")
                        }
                    }
                } else {
                    // "Any" country: validate page is available in at least one country
                    if let allPages = ZenIDManager.supportedDocumentPageCodes(for: nil, documentRole: currentRole) {
                        if !allPages.contains(currentPage) {
                            config.page = allPages.sorted(by: { $0.rawValue < $1.rawValue }).first
                            configChanged = true
                            OSLogger.app.info("Page '\(currentPage)' not available for role \(currentRole) in any country, reset")
                        }
                    } else {
                        config.page = nil
                        configChanged = true
                        OSLogger.app.info("Page '\(currentPage)' not available for role \(currentRole) in any country, reset")
                    }
                }
            }
        }
        page = config.page == nil ? "None" : "\(config.page!)"

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
