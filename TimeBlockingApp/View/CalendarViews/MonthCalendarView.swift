//
//  MonthCalendarView.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 11/1/24.
//

import SwiftUI

struct MonthCalendarView: View {
    @Binding var presentSideMenu: Bool
    @State private var displayDate = Date()
    let onDaySelected: (Date) -> Void

    var body: some View {
        VStack {
//            HorizontalCalendarViewRepresentable(onDaySelected: onDaySelected)

            ZStack {
                Color.clear
                MonthGrid(date: displayDate, onDaySelected: onDaySelected)
            }
//            .contentShape(Rectangle())
//            .gesture(
//                DragGesture()
//                    .onEnded { value in
//                        if value.translation.width < 0 { // Swipe left
//                            displayDate = Calendar.current.date(byAdding: .month, value: 1, to: displayDate)!
//                        } else if value.translation.width > 0 { // Swipe right
//                            displayDate = Calendar.current.date(byAdding: .month, value: -1, to: displayDate)!
//                        }
//                    }
//            )
//            .animation(.easeInOut)
        }
    }
}

//struct HorizontalCalendarViewRepresentable: UIViewControllerRepresentable {
//    let onDaySelected: (Date) -> Void
//
//    func makeUIViewController(context: Context) -> HorizontalCalendarViewController {
//        return HorizontalCalendarViewController(onDaySelected: onDaySelected)
//    }
//
//    func updateUIViewController(_ uiViewController: HorizontalCalendarViewController, context: Context) {}
//}

#Preview {
    MonthCalendarView(presentSideMenu: .constant(false), onDaySelected: { _ in })
}
