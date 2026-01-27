//
//  PickerScreen.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 17.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI

struct PickerScreen: View, IdentifiableScreen {
    
    @StateObject var viewModel: PickerViewModel
    
    var body: some View {
        ScrollViewReader { reader in
            switch viewModel.state {
            case .loading:
                WaitView(title: "Loading...", icon: "icloud.and.arrow.down", rotate: false)
            case .failure:
                FailureView(title: "Loading failed\r\n(not authorized?)")
            case .done:
                VStack {
                    List {
                        Section {
                            ForEach(viewModel.options, id: \.self) { option in
                                Button(action: {
                                    viewModel.selectOption(option)
                                }, label: {
                                    HStack {
                                        Text(option)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: option == viewModel.selectedOption ? "inset.filled.circle" : "circle")
                                    }
                                    .padding(.vertical, 8)
                                })
                                .id(option)
                            }
                        }
                    }
                    .onChange(of: viewModel.options) { _ in
                        // Ensure options are loaded before scrolling
                        Task {
                            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
                            if viewModel.options.contains(viewModel.selectedOption) {
                                withAnimation {
                                    reader.scrollTo(viewModel.selectedOption, anchor: .top)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle(viewModel.title)
        .toolbar {
            switch viewModel.configurationValue {
            case .country: EmptyView()
            case .profile: Button("Default") { viewModel.selectOption("") }
            default: Button("None") { viewModel.selectOption("") }
            }
        }
    }
}

#Preview {
    PickerScreen(viewModel: PickerViewModel(configurationValue: .country))
}
