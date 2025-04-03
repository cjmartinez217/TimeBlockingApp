//
//  HorizontalCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 3/25/25.
//

import SwiftUI

struct HorizontalCalendarView: View {
    @State var events: [EventModel] = SampleData().events
    @State var currentDate: Date = Date()
    @State var targetDate: Date?
    @State var selectedItem: EventModel?

    @ObservedObject var settings: CustomSettings = CustomSettings(numOfDays: 7, setDate: Date())


    var body: some View {
        VStack(spacing: 0.0) {
//            calendarHeader(height: 42.0)
            InfiniteCalendar<EventBlockView, EventBlock, CustomSettings>(events: $events, settings: settings, targetDate: $targetDate)
                .onCurrentDateChanged { date in
                    // Don't recommend update date of @Sate variable (if you defined) with date obtained.
                    // Because, if update @State variable, InfiniteCalendar will start re-rendaring then it will use CPU too much.
                    if currentDate.month != date.month {
                        currentDate = date
                        print("update current month: \(date)")
                    }
                }
                .onItemSelected { item in
                    selectedItem = item
                }
                .onEventAdded { item in
                    events.append(item)
                }
                .onEventMoved { item in
                    if let index = events.firstIndex(where: {$0.id == item.id}) {
                        events[index] = item
                    }
                }
                .onEventCanceled { _ in
                    print("Canceled some event gesture.")
                }
        }
        .sheet(item: $selectedItem, onDismiss: { selectedItem = nil }, content: { EventDetailView(event: $0) })
        .ignoresSafeArea(.container, edges: .bottom)
    }

    private func calendarHeader(height: CGFloat) -> some View {
        let darkGray: Color = Color(red: 95.0/255.0, green: 98.0/255.0, blue: 103.0/255.0)
        var formatter: DateFormatter {
            let isCurrentYear = currentDate.year == Date().year
            let df = DateFormatter()
            df.dateFormat = isCurrentYear ? "MMMM" : "MMM \(currentDate.year)"
            return df
        }

        return HStack(spacing: 26.0) {
            Text(formatter.string(from: currentDate))
                .font(.system(size: 17.0))
                .bold()
                .padding(.leading, 12.0)

            Spacer()
            Button(action: { targetDate = Date() }) {
                Image(systemName: "calendar")
                    .font(.system(size: 22.0))
                    .foregroundColor(darkGray)
            }
            Menu {
                Button(action: { settings.updateScrollType(numOfDays: 1) }, label: {
                    Label("Day", image: "day")
                })
                Button(action: { settings.updateScrollType(numOfDays: 3) }, label: {
                    Label("3 Day", image: "3day")
                })
                Button(action: { settings.updateScrollType(numOfDays: 7) }, label: {
                    Label("Week", image: "week")
                })
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 22.0))
                    .foregroundColor(darkGray)
            }
        }
        .padding(.horizontal, 11.0)
        .frame(height: height)
    }
}

#Preview {
    HorizontalCalendarView()
}
