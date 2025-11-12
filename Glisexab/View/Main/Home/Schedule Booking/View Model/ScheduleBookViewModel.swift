//
//  ScheduleBookViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 12/11/25.
//

import SwiftUI
internal import Combine

final class ScheduleBookingViewModel: ObservableObject, Equatable {
    static func == (lhs: ScheduleBookingViewModel, rhs: ScheduleBookingViewModel) -> Bool {
        lhs.selectedDate == rhs.selectedDate && lhs.selectedTime == rhs.selectedTime && lhs.note == rhs.note
    }
    
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date = Date()
    @Published var note: String = ""
    
    @Published var didScheduleBooking: Bool = false
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
    
    func schedule() {
        didScheduleBooking = true
    }
}
