//
//  FailureView.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 17.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI

struct FailureView: View {
    
    let title: String
    
    var body: some View {
        VStack {
            if #available(iOS 18.0, *) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .fontWeight(.light)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.orange)
                    .imageScale(.large)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 4, trailing: 32))
            } else {
                ProgressView()
                    .controlSize(.large)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 4, trailing: 32))
            }
            
            Text(title)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    FailureView(title: "Loading failed")
}
