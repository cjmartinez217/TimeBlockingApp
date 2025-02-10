//
//  EventDetailView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 1/31/25.
//

import SwiftUI

struct EventDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @State private var showEventForm: Bool = false
    let event: EventModel // Assuming you have an Event model

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Event title with icon
                    HStack(alignment: .top, spacing: 24) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.blue)
                            .frame(width: 24, height: 24)

                        VStack(alignment: .leading) {
                            Text(event.title)
                                .foregroundStyle(.black)
                                .font(.title2)
                                .bold()
                            //TODO: fix date format
                            let displayDateTimeRange = TimeUtils.formatEventDateTime(start: event.startDate, end: event.endDate)
                            Text(displayDateTimeRange)
                                .foregroundStyle(.black)
                        }

                        Spacer()
                    }

                    // Location
                    HStack(spacing: 24) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 24))
                            .foregroundColor(.secondary)
                        Text("115 Sandra Muraida Way")
                            .foregroundStyle(.black)
                    }

                    // Reminder
                    HStack(spacing: 24) {
                        Image(systemName: "bell")
                            .font(.system(size: 24))
                            .foregroundColor(.secondary)
                        Text("30 minutes before")
                            .foregroundStyle(.black)
                    }

                    // Description
                    if let description = event.description {
                        HStack(spacing: 24) {
                            Image(systemName: "text.alignleft")
                                .foregroundColor(.secondary)
                                .font(.system(size: 24))
                            Text(description)
                                .foregroundStyle(.black)
                        }
                    }

                    Spacer()
                }
                .padding(.all, 20)

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .font(.system(size: 20, weight: .semibold))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {
                            showEventForm = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.primary)
                                .font(.system(size: 20, weight: .semibold))
                        }

                        Button(action: {
                            calendarViewModel.deleteEvent(with: event.id)
                            dismiss()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.primary)
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }
                }
            }
            .sheet(isPresented: $showEventForm) {
                EventFormView(
                    isAddEventPresented: $showEventForm,
                    event: event,
                    onSave: {
                        dismiss()
                    }
                )
            }
        }
    }
}

#Preview {
    EventDetailView(event:
        EventModel(
            id: UUID(),
            title: "Test1",
            startDate: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!,
            endDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
            description: "testing"
        )
    )
}
