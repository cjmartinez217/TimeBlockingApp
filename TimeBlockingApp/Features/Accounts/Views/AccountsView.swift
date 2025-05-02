//
//  AccountsView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/2/24.
//

import SwiftUI



struct AccountsView: View {
    @State private var profiles: [CalendarModel] = [
        CalendarModel(name: "Lucas Werneck", email: "Lucasrw2k@gmail.com", isActive: true),
        CalendarModel(name: "Lucas Werneck - Work", email: "lucas@hellogov.ai", isActive: false),
        CalendarModel(name: "Christian Martinez", email: "lucasrw3k@gmail.com", isActive: true)
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            header
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(profiles) { profile in
                        profileView(for: profile)
                    }
                }
                .padding(.horizontal, 8)
                addButton
            }
        }
    }
    
    var header: some View {
        Text("Manage Accounts")
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 10)
    }

    // Profile view that takes a Profile object
    func profileView(for profile: CalendarModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                profileIcon(for: profile.name)
                VStack(alignment: .leading) {
                    Text(profile.name)
                        .font(.system(size: 15.0))
                    Text(profile.email)
                        .font(.system(size: 12.0))
                }
                .padding(.leading, 10)
                Spacer()
                Toggle(isOn: binding(for: profile)) {
                    EmptyView()
                }
                .labelsHidden()
            }
            Button(action: {
                removeProfile(profile)
            }) {
                Text("Remove Account")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 0.5)
        )
    }
    
    func profileIcon(for name: String) -> some View {
            ZStack {
                Circle()
                    .frame(width: 45.0)
                    .foregroundColor(.gray)
                Text(String(name.prefix(1)))
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        }
    
    // Add a new profile
    var addButton: some View {
        Button(action: {
            profiles.append(CalendarModel(name: "New User", email: "newuser@gmail.com", isActive: false))
        }) {
            Text("Add Account")
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
    
    // Remove a profile
    func removeProfile(_ profile: CalendarModel) {
        profiles.removeAll { $0.id == profile.id }
    }
    
    // Binding for each profile's isActive state
    func binding(for profile: CalendarModel) -> Binding<Bool> {
        guard let index = profiles.firstIndex(where: { $0.id == profile.id }) else {
            return .constant(false)
        }
        return $profiles[index].isActive
    }
}

#Preview {
    AccountsView()
}
