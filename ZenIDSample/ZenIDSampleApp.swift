//
//  ZenID_SampleApp.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
import ZenID
import OSLog

let storageCredentials = "zenid.sample.credentials"
let storageConfiguration = "zenid.sample.configuration"

struct SampleLogger: ZenidLogger {
    func error(_ message: String) {
        os_log(.error, "%@", message)
    }
    
    func warn(_ message: String) {
        os_log(.fault, "%@", message)
    }
    
    func info(_ message: String) {
        os_log(.info, "%@", message)
    }
    
    func debug(_ message: String) {
        os_log(.debug, "%@", message)
    }
    
    func verbose(_ message: String) {
        os_log(.info, "%@", message)
    }
    
    
}

@main
struct ZenIDSampleApp: App {

    @StateObject var navigationManager = NavigationManager()

    let logger = SampleLogger()


    init() {
        ZenIDManager.setLogger(SampleLogger())
        ZenIDManager.setLanguageFromDevice()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                MainScreen()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .login:
                        LoginScreen()
                    case .profile:
                        PickerScreen(viewModel: PickerViewModel(configurationValue: .profile))
                    case .pickCountry:
                        PickerScreen(viewModel: PickerViewModel(configurationValue: .country))
                    case .pickRole:
                        PickerScreen(viewModel: PickerViewModel(configurationValue: .role))
                    case .pickPage:
                        PickerScreen(viewModel: PickerViewModel(configurationValue: .page))
                    case .documentScanner:
                        SampleScreen(viewModel: DocumentViewModel())
                    case .hologramCheck:
                        SampleScreen(viewModel: HologramViewModel())
                    case .facelivenessCheck:
                        SampleScreen(viewModel: FaceLivenessViewModel())
                    case .msLivenessCheck:
                        SampleScreen(viewModel: MsLivenessViewModel())
                    case .licencePlateCheck:
                        SampleScreen(viewModel: LicencePlateViewModel())
                    case .selfieCheck:
                        SampleScreen(viewModel: SelfieViewModel())
                    case .result(let investigateResponse):
                        ResultScreen(investigation: investigateResponse)
                    }
                }
            }
            .environmentObject(navigationManager)
        }
    }

}
