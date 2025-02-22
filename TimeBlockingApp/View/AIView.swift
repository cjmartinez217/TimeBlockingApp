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
    @State private var rotation: Double = 0
    @State private var isSpinning: Bool = false
    @State private var scale: CGFloat = 1.0
    @State private var isPulsing: Bool = false
    @State private var shadowRadius: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
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
                    .frame(width: UIScreen.main.bounds.width * 0.85)
                    .frame(height: UIScreen.main.bounds.width * 0.85) 
                    .background(Color.white)
                    .cornerRadius(20) 
                    .shadow(radius: 10)
                    .padding(.bottom, 40) 
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
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
            isMicOn.toggle() 
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
            .scaleEffect(scale)
            .rotationEffect(Angle(degrees: rotation))
            .animation(.linear(duration: 2).repeatCount(1, autoreverses: false), value: rotation)
            .onTapGesture {
                guard !isSpinning else { return }
                isSpinning = true
                rotation += 360
                
                isPulsing = true
                withAnimation(.easeInOut(duration: 0.5).repeatCount(4, autoreverses: true)) {
                    scale = 1.2
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSpinning = false
                    isPulsing = false
                    scale = 1.0
                }
            }
            .animation(.easeInOut, value: isDisabled)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    @Previewable @State var isPresented = true
    @Previewable @State var isDisabled = false
    AIModal(isPresented: $isPresented, isDisabled: $isDisabled)
}
