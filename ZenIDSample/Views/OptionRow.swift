//
//  OptionRow.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI

struct OptionRow: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    let title: String
    
    let value: String?
    
    let systemImage: String
    
    let screen: Screen
    
    init(title: String, value: String? = nil, systemImage: String, screen: Screen) {
        self.title = title
        self.value = value
        self.systemImage = systemImage
        self.screen = screen
    }
    
    var body: some View {
        Button(action: {
            navigationManager.navigate(to: screen)
        }, label: {
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 4)
                Text(title)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 4)
                Spacer()
                if let value {
                    Text(value)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 4)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.accent)
            }
            .padding(.vertical, 8)
            .background(Color.primary.opacity(0))
        })
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    OptionRow(title: "Example", systemImage: "circle", screen: .login)
}
