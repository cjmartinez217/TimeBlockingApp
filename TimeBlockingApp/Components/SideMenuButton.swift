//
//  SideMenuButton.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct SideMenuButton: View {
    @Binding var presentSideMenu: Bool

    var body: some View {
        Button {
            presentSideMenu.toggle()
        } label: {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(Color(.black))
        }
    }
}

#Preview {
    SideMenuButton(presentSideMenu: .constant(false))
}
