//
//  SlideableCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 2/14/25.
//

import SwiftUI

struct SlideableCalendarView<Content: View>: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    let content: Content
    let previousContent: Content
    let nextContent: Content
    let onSwipeLeft: () -> Void
    let onSwipeRight: () -> Void
    @State private var dragOffset: CGFloat = 0

    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder previousContent: () -> Content,
        @ViewBuilder nextContent: () -> Content,
        onSwipeLeft: @escaping () -> Void,
        onSwipeRight: @escaping () -> Void
    ) {
        self.content = content()
        self.previousContent = previousContent()
        self.nextContent = nextContent()
        self.onSwipeLeft = onSwipeLeft
        self.onSwipeRight = onSwipeRight
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                previousContent
                    .frame(width: geometry.size.width)
                content
                    .frame(width: geometry.size.width)
                nextContent
                    .frame(width: geometry.size.width)
            }
            .offset(x: -geometry.size.width - dragOffset)
            .gesture(
                DragGesture()
                .onChanged { value in
                    dragOffset = -value.translation.width
                }
                .onEnded { value in
                    let threshold = geometry.size.width * 0.2
                    let dragWidth = value.translation.width

                    withAnimation(.easeInOut(duration: 0.3)) {
                        if dragWidth < -threshold {
                            // Swipe left
                            dragOffset = geometry.size.width
                            onSwipeLeft()
                        } else if dragWidth > threshold {
                            // Swipe right
                            dragOffset = -geometry.size.width
                            onSwipeRight()
                        } else {
                            // Reset
                            dragOffset = 0
                        }
                    }

                    // Reset after animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        dragOffset = 0
                    }
                }
            )
        }
    }
}
