//
//  AIView.swift
//  TimeBlockingApp
//
//  Created by Lucas Werneck on 2/23/25.
//

import LiveKit
import SwiftUI
#if os(iOS) || os(macOS)
import LiveKitKrispNoiseFilter
#endif

struct AIModal: View {
    @StateObject private var room = Room()
    
#if os(iOS) || os(macOS)
    private let krispProcessor = LiveKitKrispNoiseFilter()
#endif
    
    init() {
#if os(iOS) || os(macOS)
        AudioManager.shared.capturePostProcessingDelegate = krispProcessor
#endif
    }
    
    var body: some View {
        VStack(spacing: 8) {
            StatusView()
                .frame(height: 256)
                .frame(maxWidth: 256)
            ControlBar()
        }
        .padding()
        .environmentObject(room)
        .onAppear {
            room.add(delegate: krispProcessor)
        }
    }
}

#Preview {
    AIModal()
}
