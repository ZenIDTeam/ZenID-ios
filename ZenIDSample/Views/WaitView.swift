//
//  WaitView.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 17.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI

struct WaitView: View {
        
    let title: String
    
    let icon: String
    
    let rotate: Bool
    
    var body: some View {
        VStack {
            if #available(iOS 18.0, *) {
                if rotate {
                    Image(systemName: icon)
                        .resizable()
                        .fontWeight(.light)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.secondary)
                        .symbolEffect(.rotate, options: .repeat(.continuous))
                        .imageScale(.large)
                        .padding(EdgeInsets(top: 32, leading: 32, bottom: 4, trailing: 32))
                } else {
                    Image(systemName: icon)
                        .resizable()
                        .fontWeight(.light)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.secondary)
                        .symbolEffect(.wiggle, options: .repeat(.continuous))
                        .imageScale(.large)
                        .padding(EdgeInsets(top: 32, leading: 32, bottom: 4, trailing: 32))
                }
            } else {
                ProgressView()
                    .controlSize(.large)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 4, trailing: 32))
            }
            Text(title)
                .padding(EdgeInsets(top: 4, leading: 32, bottom: 16, trailing: 32))
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    WaitView(title: "Loading...", icon: "mail.and.text.magnifyingglass", rotate: false)
}
