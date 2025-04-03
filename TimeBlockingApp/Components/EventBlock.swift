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
//        let durationInMinutes = event.endDate.timeIntervalSince(event.startDate) / 60
//        let eventHeight =  durationInMinutes / 60 * Constants.hourHeight


        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 3.0)
                .foregroundColor(eventViewModel.editState == .resizing ? Color.white.opacity(0.3) : eventViewModel.color)
//                .overlay(border)
//                .overlay(streachGuide)
                .shadow(color: eventViewModel.editState == .moving ? Color.black.opacity(0.4) : .clear, radius: 1.0, x: 0.0, y: 1.0)
            Text(eventViewModel.title)
                .font(.system(size: 12))
                .bold()
                .lineSpacing(0)
                .foregroundColor(eventViewModel.editState == .resizing ? .clear : .white)
                .padding(EdgeInsets(top: 6.0, leading: 4.0, bottom: 0, trailing: 0))
        }

//        Button(action: {
//            showingDetail = true
//        }) {
//            VStack(alignment: .leading) {
//                Text(eventViewModel.title)
//                    .font(.system(size: 14, weight: .bold))
//                    .foregroundStyle(.white)
//                    .padding(.leading, 12)
//                    .padding(.top, 4)
//                Spacer()
//            }
//            .frame(height: 100) // height ?? eventHeight)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.blue)
//            .cornerRadius(6)
//            .fullScreenCover(isPresented: $showingDetail) {
//                EventDetailView(event: eventViewModel)
//            }
//        }
    }
}

#Preview {
    EventBlockView(EventModel(title: "Test", startDate: Date(), endDate: Date().addingTimeInterval(60 * 60)))
}
