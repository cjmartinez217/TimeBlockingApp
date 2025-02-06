//
//  AddEventView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/31/24.
//

import SwiftUI

struct EventFormView: View {
    @Binding var isAddEventPresented: Bool
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    let event: EventModel?
    let onSave: (() -> Void)?

    @State private var title: String
    @State private var isAllDay: Bool
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var location: String
    @State private var description: String

    init(isAddEventPresented: Binding<Bool>, event: EventModel? = nil, onSave: (() -> Void)? = nil) {
        self._isAddEventPresented = isAddEventPresented
        self.event = event
        self.onSave = onSave

        if let event = event {
            _title = State(initialValue: event.title)
            _isAllDay = State(initialValue: event.isAllDay ?? false)
            _startDate = State(initialValue: event.startDate)
            _endDate = State(initialValue: event.endDate)
            _location = State(initialValue: "")
            _description = State(initialValue: event.description ?? "")
        } else {
            _title = State(initialValue: "")
            _isAllDay = State(initialValue: false)
            _startDate = State(initialValue: TimeUtils.getStartDate())
            _endDate = State(initialValue: TimeUtils.getEndDate())
            _location = State(initialValue: "")
            _description = State(initialValue: "")
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {

                // MARK: Cancel and Save buttons
                HStack {
                    Button(action: {
                        isAddEventPresented.toggle()
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
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.large)
                        .frame(width: 24)
                    TextField(text: $location) {
                        Text("Add location")
                    }
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .padding(.leading, 2)
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)

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
        let updatedEvent = EventModel(
            id: event?.id ?? UUID(),
            title: title,
            startDate: startDate,
            endDate: endDate,
            description: description,
            isAllDay: isAllDay
        )

        if event != nil {
            calendarViewModel.updateEvent(updatedEvent)
        } else {
            calendarViewModel.createEvent(updatedEvent)
        }

        isAddEventPresented.toggle()
        onSave?()
    }
}

#Preview {
    EventFormView(
        isAddEventPresented: .constant(true),
        event: EventModel(
            id: UUID(),
            title: "Test1",
            startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
            endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
            description: "testing"
        )
    )
        .environmentObject(CalendarViewModel())
}
