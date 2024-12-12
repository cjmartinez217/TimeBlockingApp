//
//  MonthGrid.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 12/10/24.
//

import SwiftUI

struct MonthGrid: View {
    let days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<7, id: \.self) { _ in
                    Divider()
                        .background(Color.gray)
                        .padding(.top, 1)
                    Spacer()
                }
            }
            Grid {
                ForEach(0..<5, id: \.self) { row in
                    Divider()
                        .background(Color.gray)
                        .frame(maxHeight: 1)
                    GridRow {
                        ForEach(0..<7, id: \.self) { column in
                            let index = row * 7 + column
                            Text("\(days[index])")
                        }
                    }
                    Spacer()
                }
            }
        }

//        ZStack {
//            HStack {
//                ForEach(0..<7, id: \.self) { _ in
//                    Divider()
//                        .background(Color.gray)
//                    Spacer()
//                }
//            }
//            .mask(
//                VStack {
//                    Spacer()
//                    Rectangle()
//                        .ignoresSafeArea()
//                        .padding(.top, -7)
//                }
//            )
//            VStack {
//                ForEach(0..<4, id: \.self) { _ in
//                    Divider()
//                        .background(Color.gray)
//                        .frame(maxHeight: 1)
//                    Spacer()
//                }
//            }
//        }
    }
}

#Preview {
    MonthGrid()
}
