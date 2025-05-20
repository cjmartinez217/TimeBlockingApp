//
//  StatusView.swift
//  TimeBlockingApp
//
//  Created by Lucas Werneck on 5/19/25.
//

import LiveKit
import LiveKitComponents
import SwiftUI

/// Shows a visualizer for the agent participant in the room
/// In a more complex app, you may want to show more information here
struct StatusView: View {
    // Load the room from the environment
    @EnvironmentObject private var room: Room

    // Find the first agent participant in the room
    // This assumes there's only one agent and they publish only one audio track
    // Your application may have more complex requirements
    private var agentParticipant: RemoteParticipant? {
        for participant in room.remoteParticipants.values {
            if participant.kind == .agent {
                return participant
            }
        }
        return nil
    }

    // Reads the agent state property which is updated automatically
    private var agentState: AgentState {
        agentParticipant?.agentState ?? .initializing
    }

    var body: some View {
        if let participant = agentParticipant {
            BarAudioVisualizer(audioTrack: participant.firstAudioTrack, agentState: agentState, barColor: .black.opacity(0.5), barCount: 23)
                .id(participant.firstAudioTrack?.id)
                .frame(height: 140) // Reduced height for the visualizer itself
        } else {
            // Placeholder for when agent audio isn't available yet
            Rectangle().fill(.clear)
                .frame(height: 140) // Match placeholder height
        }
    }
}
