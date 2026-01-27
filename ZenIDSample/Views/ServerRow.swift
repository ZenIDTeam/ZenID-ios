//
//  ServerRow.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI

struct ServerRow: View {
    var body: some View {
        HStack {
            Image(systemName: "qrcode.viewfinder")
            VStack(alignment: .leading) {
                Text("frauds.zenid.com")
                    .font(.body)
                Text("key")
                    .font(.caption)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.accent)
        }
        .padding(.all, 8)
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    ServerRow()
}
