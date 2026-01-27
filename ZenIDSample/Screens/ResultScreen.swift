//
//  ResultScreen.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 16.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
import ZenID

struct ResultScreen: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    let investigation: InvestigateSamplesResponse
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    let text = "\(investigation)".replacingOccurrences(of: "Optional", with: "")
                    Text(text)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.secondary.opacity(0.2))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 5)))
                .padding()
            }
            Spacer()
            Button {
                navigationManager.pop(steps: 2)
            } label: {
                Text("Close")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
        .navigationTitle("Investigation")
    }
    
}

#Preview {
    // Create a mock investigation response for preview
    let jsonData = """
    {
        "InvestigationID": 123456789,
        "ErrorCode": null
    }
    """.data(using: .utf8)!
    let mockResponse = try! JSONDecoder().decode(InvestigateSamplesResponse.self, from: jsonData)
    return ResultScreen(investigation: mockResponse)
}
