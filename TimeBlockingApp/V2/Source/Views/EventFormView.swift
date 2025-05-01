//
//  AddEventView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/31/24.
//

import SwiftUI

struct EventFormView: View {
    let date: Date
    let event: EventModel?
    let onSave: (() -> Void)?
    @Binding var isPresented: Bool

    @ObservedObject private var eventStore = MockEventStore.shared

    @State private var title: String
    @State private var isAllDay: Bool
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var description: String

    init(
        date: Date,
        isPresented: Binding<Bool>,
        event: EventModel? = nil,
        onSave: (() -> Void)? = nil
    ) {
        self.date = date
        self._isPresented = isPresented
        self.event = event
        self.onSave = onSave

        // Initialize state
        if let event = event {
            _title = State(initialValue: event.title)
            _isAllDay = State(initialValue: event.isAllDay)
            _startDate = State(initialValue: event.startDate)
            _endDate = State(initialValue: event.endDate)
            _description = State(initialValue: event.description ?? "")
        } else {
            _title = State(initialValue: "")
            _isAllDay = State(initialValue: false)
            _startDate = State(initialValue: TimeUtils.getStartDate(date: date))
            _endDate = State(initialValue: TimeUtils.getEndDate(date: date))
            _description = State(initialValue: "")
        }
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {

                // MARK: Cancel and Save buttons
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .underline()
                    }
                    Spacer()
                    Button(action: {
                        saveEvent()
                    }) {
                        Text("Save")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .underline()
                    }
                }
                .foregroundStyle(.blue)
                .padding(.all)

                // MARK: Event Title
                TextField(text: $title) {
                    Text("Add title")
                }
                .multilineTextAlignment(.leading)
                .font(.system(size: 32, weight: .medium, design: .rounded))
                .padding(.leading, 42)
                .padding(.vertical, 16)

                Divider()

                // MARK: Event Time Block
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                        Toggle(isOn: $isAllDay) {
                            Text("All-day")
                        }
                    }

                    HStack {
                        DatePickerView(
                            selection: $startDate,
                            displayedComponents: .date
                        )
                        Spacer()
                        if !isAllDay {
                            DatePickerView(
                                selection: $startDate,
                                displayedComponents: .hourAndMinute
                            )
                        }
                    }
                    .padding(.leading, 34)
                    HStack {
                        DatePickerView(
                            selection: $endDate,
                            minDate: startDate,
                            displayedComponents: .date
                        )
                        Spacer()
                        if !isAllDay {
                            DatePickerView(
                                selection: $endDate,
                                minDate: startDate,
                                displayedComponents: .hourAndMinute
                            )
                        }
                    }
                    .padding(.leading, 34)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                Divider()

                // MARK: Location
//                HStack {
//                    Image(systemName: "mappin.and.ellipse")
//                        .imageScale(.large)
//                        .frame(width: 24)
//                    TextField(text: $location) {
//                        Text("Add location")
//                    }
//                    .multilineTextAlignment(.leading)
//                    .font(.system(size: 24, weight: .regular, design: .rounded))
//                    .padding(.leading, 2)
//                    Spacer()
//                }
//                .padding(.leading, 16)
//                .padding(.vertical, 16)

                Divider()

                // MARK: Notification
                HStack {
                    Image(systemName: "bell")
                        .imageScale(.large)
                    Text("Add a notification")
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .padding(.leading, 2)
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)

                Divider()

                // MARK: Color
                HStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blue)
                        .frame(width: 24, height: 24)
                    Text("Default color")
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .padding(.leading, 6)
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)

                Divider()

                // MARK: Description
                HStack {
                    Image(systemName: "text.justify.left")
                        .imageScale(.large)
                        .frame(width: 24)
                    TextField(text: $description) {
                        Text("Add description")
                    }
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .padding(.leading, 2)
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)
                Divider()
                Spacer()
            }
            .foregroundStyle(.black)
            .onChange(of: startDate) { newStartDate in
                if endDate < newStartDate {
                    endDate = Calendar.current.date(byAdding: .hour, value: 1, to: newStartDate)!
                }
            }
        }
    }

    private func saveEvent() {
        let updatedEvent: EventModel
        if let existingEvent = event {
            // Use copy() for updating existing events
            var eventCopy = existingEvent.copy()
            eventCopy.title = title.isEmpty ? "(No title)" : title
            eventCopy.startDate = startDate
            eventCopy.endDate = endDate
            eventCopy.intraStartDate = startDate
            eventCopy.intraEndDate = endDate
            eventCopy.description = description.isEmpty ? nil : description
            eventCopy.isAllDay = isAllDay
            updatedEvent = eventCopy
        } else {
            // Create new event
            updatedEvent = EventModel(
                title: title.isEmpty ? "(No title)" : title,
                startDate: startDate,
                endDate: endDate,
                description: description.isEmpty ? "" : description,
                isAllDay: isAllDay
            )
        }

        if event != nil {
            eventStore.updateEvent(updatedEvent)
        } else {
            eventStore.addEvent(updatedEvent)
        }

        isPresented = false
        onSave?()
    }
}

#Preview {
    EventFormView(
        date: Date(),
        isPresented: .constant(true),
        event: EventModel(
            title: "Test1",
            startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
            endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
            description: "testing"
        )
    )
}
