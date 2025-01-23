//
//  AIView.swift
//  TimeBlockingApp
//
//  Created by Lucas Werneck Dev on 1/21/25.
//


import SwiftUI

struct AIModal: View {
    @Binding var isPresented: Bool
    @Binding var isDisabled: Bool
    @State private var isSpeakerOn: Bool = true
    @State private var isMicOn: Bool = true 

    var body: some View {
        VStack() {
            Spacer()
            VStack {
                Text("AI NAME")
                    .font(.title)
                    .padding(.top, 20)

                Spacer()
                
                AIIcon

                Spacer()

                HStack(spacing: 20) {
                    speakerIcon
                    microphoneIcon
                    escapeIcon
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: UIScreen.main.bounds.height / 2)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .transition(.move(edge: .bottom))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea()) // Dimmed background
    }
    
    var speakerIcon: some View {
        Button(action: {
            isSpeakerOn.toggle()
            print("Speaker button toggled: \(isSpeakerOn ? "On" : "Off")")
        }) {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                Image(systemName: isSpeakerOn ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    var microphoneIcon: some View {
        Button(action: {
            isMicOn.toggle() // Toggle mic state
            print("Mic button toggled: \(isMicOn ? "On" : "Off")")
        }) {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                Image(systemName: isMicOn ? "mic.fill" : "mic.slash.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    var escapeIcon: some View {
        Button(action: {
            isPresented = false
        }) {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    var AIIcon: some View {
        Circle()
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: isDisabled
                        ? [Color(red: 0.8, green: 0.1, blue: 0.1), Color(red: 0.1, green: 0.1, blue: 0.6)]
                        : [Color.red, Color.blue]
                    ),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading),
                style: StrokeStyle(lineWidth: 12)
            )
            .frame(width: 120, height: 120)
            .animation(.easeInOut, value: isDisabled)
    }
}

#Preview {
    @Previewable @State var isPresented = true
    @Previewable @State var isDisabled = false
    AIModal(isPresented: $isPresented, isDisabled: $isDisabled)
}
