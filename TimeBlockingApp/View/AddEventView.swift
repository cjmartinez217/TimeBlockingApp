//
//  AddEventView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/31/24.
//

import SwiftUI

struct AddEventView: View {
    @Binding var isAddEventPresented: Bool

    @State private var title: String = ""
    @State private var isAllDay = false
    @State private var startDate = TimeUtils.getStartDate()
    @State private var endDate = TimeUtils.getEndDate()
    @State private var location: String = ""
    @State private var description: String = ""
    @EnvironmentObject var calendarViewModel: CalendarViewModel

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
                        createAndSaveEvent()
                    }) {
                        Text("Save")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .underline()
                    }
                }
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
                    TextField(text: $location) {
                        Text("Add location")
                    }
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .padding(.leading, 2)
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
                    RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
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
                    TextField(text: $description) {
                        Text("Add description")
                    }
                    .font(.system(size: 24, weight: .regular, design: .rounded))
                    .padding(.leading, 2)
                }
                .padding(.leading, 16)
                .padding(.vertical, 16)
                Divider()
                Spacer()
            }
            .onChange(of: startDate) { newStartDate in
                if endDate < newStartDate {
                    endDate = Calendar.current.date(byAdding: .hour, value: 1, to: newStartDate)!
                }
            }
        }
    }

    func createAndSaveEvent() {
        let newEvent = EventModel(
            title: title,
            startDate: startDate,
            endDate: endDate,
            description: description,
            isAllDay: isAllDay
        )
        calendarViewModel.createEvent(newEvent)
        isAddEventPresented.toggle()
    }
}

#Preview {
    AddEventView(isAddEventPresented: .constant(true))
        .environmentObject(CalendarViewModel())
}
