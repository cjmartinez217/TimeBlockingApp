//
//  SideMenuDetailView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/2/24.
//

import SwiftUI

struct SideMenuDetailView: View {
    let page: SideMenuPage
    let onClose: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button("Close") {
                    onClose()
                }
                .padding()
                Spacer()
            }
            Spacer()
            switch page {
            case .accounts:
                AccountsView()
            case .settings:
                SettingsView()
            case .feedback:
                FeedbackView()
            }
            Spacer()
        }
    }
}

#Preview {
    SideMenuDetailView(page: .accounts, onClose: {})
}
