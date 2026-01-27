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
    
    private var config: DocumentConfiguration = .load(key: storageConfiguration, defaultValue: DocumentConfiguration(country: .cz))!
    
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
                self.options = ZenIDManager.supportedCountries()?.map({ "\($0)" }) ?? []
                self.selectedOption = "\(config.country)"
            case .role:
                self.options = ZenIDManager.supportedDocuments(for: config.country)?.map({ "\($0)" }) ?? []
                if let role = config.role {
                    self.selectedOption = "\(role)"
                }
            case .page:
                if let role = config.role {
                    self.options = ZenIDManager
                        .supportedDocumentPageCodes(for: config.country, documentRole: role)?
                        .sorted(by: { $0.rawValue < $1.rawValue })
                        .map({ "\($0)" }) ?? []
                } else {
                    self.options = ["f", "b"]
                }
                if let page = config.page {
                    self.selectedOption = "\(page)"
                }
            }
            OSLogger.app.error("Options loaded")
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
            config.country = ZenIDManager.supportedCountries()?.first(where: { "\($0)" == option }) ?? .cz
        case .role:
            config.role = ZenIDManager.supportedDocuments(for: config.country)?.first(where: { "\($0)" == option })
            if let role = config.role {
                config.page = ZenIDManager
                    .supportedDocumentPageCodes(for: config.country, documentRole: role)?
                    .sorted(by: { $0.rawValue < $1.rawValue })
                    .first
            }
        case .page:
            if let role = config.role {
                config.page = ZenIDManager.supportedDocumentPageCodes(for: config.country, documentRole: role)?.first(where: { "\($0)" == option })
            } else {
                config.page = option == "f" ? .f : .b
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
