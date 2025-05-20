//
//  ControlBar.swift
//  TimeBlockingApp
//
//  Created by Lucas Werneck on 5/19/25.
//

import LiveKit
import LiveKitComponents
import SwiftUI

// The ControlBar component handles connection, disconnection, and audio controls
struct ControlBar: View {
    @EnvironmentObject private var tokenService: TokenService
    @EnvironmentObject private var room: Room

    @State private var isConnecting: Bool = false
    @State private var isDisconnecting: Bool = false
    @Namespace private var animation
    @State private var rotationDegrees: Double = 0
    @State private var showCentralControls: Bool = false
    @State private var showAIButton: Bool = true

    private enum Configuration {
        case disconnected, connected, transitioning
    }

    private var currentConfiguration: Configuration {
        if isConnecting || isDisconnecting {
            return .transitioning
        } else if room.connectionState == .disconnected {
            return .disconnected
        } else {
            return .connected
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Center controls
            if showCentralControls {
                HStack(spacing: 12) {
                    HStack(spacing: 8) {
                        // Mute button
                        TBPrimaryButton(
                            icon: TBIcon(
                                room.localParticipant.isMicrophoneEnabled() ? "mic" : "mic.slash",
                                size: .medium,
                                weight: .regular,
                                theme: .dark
                            ),
                            size: .medium,
                            theme: .standard,
                            background: .none,
                            action: {
                                Task {
                                    try? await room.localParticipant.setMicrophone(
                                        enabled: !room.localParticipant.isMicrophoneEnabled())
                                }
                            }
                        )
                        
                        // Audio visualizer
                        LocalAudioVisualizer(track: room.localParticipant.firstAudioTrack)
                            .frame(height: 44)
                            .id(room.localParticipant.firstAudioTrack?.id ?? "no-track")
                            .padding(.trailing, 8)
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Exit button
                    TBPrimaryButton(
                        icon: TBIcon("xmark", size: .medium, weight: .bold, theme: .light),
                        size: .medium,
                        theme: .bold,
                        background: .destructive,
                        action: disconnect
                    )
                }
                .padding(.bottom, 16)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
            }
            
            // Right-aligned AI Button
            HStack {
                Spacer() // Push to right
                
                if showAIButton {
                    if currentConfiguration == .disconnected {
                        // Normal AI Button
                        AIButton(isDisabled: $isConnecting, onTap: connect)
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    } else if isConnecting {
                        // Spinning AI Button during connection
                        AIButton(isDisabled: .constant(true), onTap: {})
                            .rotationEffect(Angle(degrees: rotationDegrees))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                    rotationDegrees = 360
                                }
                            }
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    }
                }
            }
        }
        .onChange(of: currentConfiguration) { oldValue, newValue in
            // Handle state transitions with proper animations
            if newValue == .connected && oldValue == .transitioning {
                // When connection completes
                withAnimation(.easeInOut(duration: 0.3)) {
                    showAIButton = false
                }
                // Delay showing the central controls
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showCentralControls = true
                    }
                }
            } else if newValue == .disconnected && (oldValue == .connected || oldValue == .transitioning) {
                // When disconnection completes
                withAnimation(.easeInOut(duration: 0.3)) {
                    showCentralControls = false
                }
                // Delay showing the AI button
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showAIButton = true
                    }
                }
            }
        }
        .onAppear {
            // Initialize visibility states based on current configuration
            showAIButton = currentConfiguration == .disconnected || isConnecting
            showCentralControls = currentConfiguration == .connected && !isConnecting
        }
    }

    private func connect() {
        Task {
            isConnecting = true
            
            // Generate a random room name to ensure a new room is created
            let roomName = "room-\(Int.random(in: 1000 ... 9999))"
            let participantName = "user-\(Int.random(in: 1000 ... 9999))"

            do {
                // Fetch connection details from token service
                if let connectionDetails = try await tokenService.fetchConnectionDetails(
                    roomName: roomName,
                    participantName: participantName
                ) {
                    // Connect to the room and enable the microphone
                    try await room.connect(
                        url: connectionDetails.serverUrl, token: connectionDetails.participantToken
                    )
                    try await room.localParticipant.setMicrophone(enabled: true)
                } else {
                    print("Failed to fetch connection details")
                }
                isConnecting = false
            } catch {
                print("Connection error: \(error)")
                isConnecting = false
            }
        }
    }

    private func disconnect() {
        Task {
            isDisconnecting = true
            
            // Start fading out controls immediately when disconnect is pressed
            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showCentralControls = false
                }
            }
            
            // Wait for fade-out to complete before disconnecting
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
            
            // Disconnect from room
            await room.disconnect()
            
            isDisconnecting = false
            
            // AI button will fade in automatically due to onChange handler
        }
    }
}

// Displays real-time audio levels for the local participant
private struct LocalAudioVisualizer: View {
    var track: AudioTrack?

    @StateObject private var audioProcessor: AudioProcessor

    init(track: AudioTrack?) {
        self.track = track
        _audioProcessor = StateObject(
            wrappedValue: AudioProcessor(
                track: track,
                bandCount: 9,
                isCentered: false
            ))
    }

    public var body: some View {
        HStack(spacing: 3) {
            ForEach(0 ..< 9, id: \.self) { index in
                Rectangle()
                    .fill(.primary)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .scaleEffect(
                        y: max(0.05, CGFloat(audioProcessor.bands[index])), anchor: .center
                    )
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 0)
        .padding(.trailing, 8)
    }
}

// (fake) button shown during connection state transitions
private struct TransitionButton: View {
    var isConnecting: Bool

    var body: some View {
        Button(action: {}) {
            Text(isConnecting ? "Connecting…" : "Disconnecting…")
                .textCase(.uppercase)
        }
        .buttonStyle(.plain)
        .frame(height: 44)
        .padding(.horizontal, 16)
        .background(
            .primary.opacity(0.1)
        )
        .foregroundStyle(.secondary)
        .cornerRadius(8)
        .disabled(true)
    }
}


private struct AudioDeviceSelector: View {
    @State private var audioDevices: [AudioDevice] = []
    @State private var selectedDevice: AudioDevice = AudioManager.shared.defaultInputDevice

    var body: some View {
        Menu {
            ForEach(audioDevices, id: \.deviceId) { device in
                Button(action: {
                    selectedDevice = device
                    AudioManager.shared.inputDevice = device
                }) {
                    HStack {
                        Text(device.name)
                        if device.deviceId == selectedDevice.deviceId {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            TBPrimaryButton(
                icon: TBIcon("chevron.down", size: .medium, weight: .bold, theme: .dark),
                size: .medium,
                theme: .bold,
                background: .none,
                action: {}
            )
        }
        .onAppear {
            updateDevices()

            // Listen for audio device changes
            // Note that this listener is global so can only override it from one spot
            // In a more complex app, you may need a different approach
            AudioManager.shared.onDeviceUpdate = { _ in
                Task { @MainActor in
                    updateDevices()
                }
            }
        }.onDisappear {
            AudioManager.shared.onDeviceUpdate = nil
        }
    }

    private func updateDevices() {
        audioDevices = AudioManager.shared.inputDevices
        selectedDevice = AudioManager.shared.inputDevice
    }
}
