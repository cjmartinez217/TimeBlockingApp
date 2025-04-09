//
//  SideMenuModifier.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 4/5/25.
//

import SwiftUI

struct SideMenuModifier<SideMenuContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let menuWidth: CGFloat
    let sideMenuContent: () -> SideMenuContent

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    .transition(.opacity)

                HStack {
                    sideMenuContent()
                        .frame(width: menuWidth)
                        .zIndex(1)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

extension View {
    func sideMenu<Content: View>(
        isPresented: Binding<Bool>,
        menuWidth: CGFloat = 250,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(SideMenuModifier(isPresented: isPresented, menuWidth: menuWidth, sideMenuContent: content))
    }
}
