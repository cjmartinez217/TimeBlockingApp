//
//  EventBlock.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/20/25.
//

import SwiftUI

final class EventBlock: ViewHostingCell<EventBlockView> {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

struct EventBlockView: CellableView {
    typealias VM = EventModel
    var eventViewModel: EventModel
    init(_ eventViewModel: EventModel) {
        self.eventViewModel = eventViewModel
    }

    var height: CGFloat?
    @State private var showingDetail = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 3.0)
                .foregroundColor(eventViewModel.editState == .resizing ? Color.white.opacity(0.3) : eventViewModel.color)
                .shadow(color: eventViewModel.editState == .moving ? Color.black.opacity(0.4) : .clear, radius: 1.0, x: 0.0, y: 1.0)
            Text(eventViewModel.title)
                .font(.system(size: 12))
                .bold()
                .lineSpacing(0)
                .foregroundColor(eventViewModel.editState == .resizing ? .clear : .white)
                .padding(EdgeInsets(top: 6.0, leading: 4.0, bottom: 0, trailing: 0))
        }
    }
}

#Preview {
    EventBlockView(EventModel(title: "Test", startDate: Date(), endDate: Date().addingTimeInterval(60 * 60)))
}
