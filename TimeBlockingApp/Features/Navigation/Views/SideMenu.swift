//
//  SideMenu.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    @Binding var selectedTab: Int
    @State private var selectedPage: SideMenuPage?

    var body: some View {
        sideMenuContent
            .fullScreenCover(item: $selectedPage) { page in
                 SideMenuDetailView(page: page) {
                     selectedPage = nil
                 }
             }
    }

    var sideMenuContent: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Views")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 20)
                        .padding(.bottom, 10)

                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedTab == row.rawValue, title: row.title, icon: row.icon) {
                            selectedTab = row.rawValue
                            isShowing.toggle()
                        }
                    }
                    .padding(.leading)

                    Divider()
                        .padding(.vertical)

                    VStack {
                        Text("Calendars")
                            .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 20)

                    }

                    Divider()
                        .padding(.vertical)

                    // Accounts, Settings, Feedback Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Button {
                                selectedPage = .accounts
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Accounts")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.black)
                        }

                        HStack {
                            Button {
                                selectedPage = .settings
                            } label: {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Settings")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.black)
                        }

                        HStack {
                            Button {
                                selectedPage = .feedback
                            } label: {
                                Image(systemName: "bubble.left")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Send feedback")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                    Spacer()
                }
                .padding(.top, 16)
                .background(
                    Color.white
                )
            }
            Spacer()
        }
        .background(.clear)
    }

    func RowView(isSelected: Bool, title: String, icon: String, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(isSelected ? .black : .gray)
                    Text(title)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    SideMenu(isShowing: .constant(true), selectedTab: .constant(0))
}
