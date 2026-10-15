//
//  PickerViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 17.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID
import Combine

@MainActor class PickerViewModel: ObservableObject {

    @Published var state: State = .loading

    @Published var options: [String] = []

    @Published var selectedOption: String = ""

    private let anyCountryOption = NSLocalizedString("general-Any", comment: "")

    private var config: DocumentConfiguration = .load(key: storageConfiguration, defaultValue: DocumentConfiguration())!
    
    let configurationValue: ConfigurationValue
    
    var title: String {
        switch configurationValue {
        case .profile: "Profile"
        case .country: "Country"
        case .role: "Role"
        case .page: "Page"
        }
    }
    
    init(configurationValue: ConfigurationValue) {
        self.configurationValue = configurationValue
        Task { @MainActor in
            switch configurationValue {
            case .profile:
                let responseData = try? await ZenIDManager.getProfiles()
                let response = responseData.flatMap { try? ZenIDManager.decode($0, as: ProfilesResponse.self) }
                self.options = response?.results ?? []
                self.selectedOption = Profile.current
            case .country:
                var countryOptions = ZenIDManager.supportedCountries()?.map({ "\($0)" }) ?? []
                if countryOptions.count > 1 {
                    countryOptions.insert(anyCountryOption, at: 0)
                }
                self.options = countryOptions
                if let country = config.country {
                    self.selectedOption = "\(country)"
                } else if countryOptions.contains(anyCountryOption) {
                    self.selectedOption = anyCountryOption
                } else {
                    self.selectedOption = countryOptions.first ?? ""
                }
            case .role:
                if let country = config.country {
                    self.options = ZenIDManager.supportedDocuments(for: country)?.map({ "\($0)" }) ?? []
                } else {
                    self.options = (ZenIDManager.supportedDocuments(for: nil) ?? [])
                        .sorted(by: { $0.rawValue < $1.rawValue })
                        .map({ "\($0)" })
                }
                if let role = config.role {
                    self.selectedOption = "\(role)"
                }
            case .page:
                if let role = config.role {
                    self.options = (ZenIDManager.supportedDocumentPageCodes(for: config.country, documentRole: role) ?? [])
                        .sorted(by: { $0.rawValue < $1.rawValue })
                        .map({ "\($0)" })
                } else {
                    self.options = ["f", "b"]
                }
                if let page = config.page {
                    self.selectedOption = "\(page)"
                }
            }
            OSLogger.app.debug("Options loaded")
            state = .done
        }
    }
    
    func selectOption(_ option: String) {
        selectedOption = option
        switch self.configurationValue {
        case .profile:
            Profile.current = option
            // Notify SDK about profile change
            ZenIDManager.selectProfile(option)
        case .country:
            if option == anyCountryOption {
                config.country = nil
            } else {
                config.country = ZenIDManager.supportedCountries()?.first(where: { "\($0)" == option })
            }
        case .role:
            if let country = config.country {
                config.role = ZenIDManager.supportedDocuments(for: country)?.first(where: { "\($0)" == option })
                if let role = config.role {
                    config.page = ZenIDManager
                        .supportedDocumentPageCodes(for: country, documentRole: role)?
                        .sorted(by: { $0.rawValue < $1.rawValue })
                        .first
                }
            } else {
                // "Any" country: find the role from all supported documents
                config.role = ZenIDManager.supportedDocuments(for: nil)?.first(where: { "\($0)" == option })
                if let role = config.role {
                    // Collect first page from any country that supports this role
                    config.page = ZenIDManager.supportedDocumentPageCodes(for: nil, documentRole: role)?.sorted(by: { $0.rawValue < $1.rawValue }).first
                }
            }
        case .page:
            if let role = config.role {
                if let country = config.country {
                    config.page = ZenIDManager.supportedDocumentPageCodes(for: country, documentRole: role)?.first(where: { "\($0)" == option })
                } else {
                    // "Any" country: find page from any country
                    config.page = ZenIDManager.supportedDocumentPageCodes(for: nil, documentRole: role)?.first(where: { "\($0)" == option })
                }
            } else {
                config.page = [PageCodes.f, .b].first(where: { "\($0)" == option })
            }
        }
        do {
            try config.save(key: storageConfiguration)
        } catch {
            OSLogger.app.error("Can't save configuration: \(error)")
        }
    }
    
    enum State {
        case loading
        case failure
        case done
    }
    
    enum ConfigurationValue {
        case profile
        case country
        case role
        case page
    }
}
