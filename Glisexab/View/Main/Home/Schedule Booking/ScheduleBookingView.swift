//
//  ScheduleBookingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/10/25.
//

import SwiftUI

struct ScheduleBookingView: View {
    
    @State private var selectedDate = Date()
    @State private var showDatePicker: Bool = false
    
    @State private var selectedTime = Date()
    @State private var showTimePicker: Bool = false
    
    @State private var note: String = ""
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: selectedTime)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: TOP BAR
            ZStack {
                TopBarView(showBack: false)
                HStack {
                    Button {
                        print("Tab Left Button")
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Spacer()
                    }
                    .padding()
                }
            }
            
            VStack(alignment: .leading, spacing: 18) {
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date")
                            .font(.customfont(.medium, fontSize: 14))
                        Button {
                            showDatePicker = true
                        } label: {
                            Text(formattedDate)
                                .font(.customfont(.regular, fontSize: 14))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color(.white))
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showDatePicker) {
                            if #available(iOS 16.0, *) {
                                VStack {
                                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                                        .datePickerStyle(.graphical)
                                        .padding()
                                    
                                    Button("Done") {
                                        showDatePicker = false
                                    }
                                    .padding(.top, 10)
                                }.presentationDetents([.medium])
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .font(.customfont(.medium, fontSize: 14))
                        Button {
                            showTimePicker = true
                        } label: {
                            Text(formattedTime)
                                .font(.customfont(.regular, fontSize: 14))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color(.white))
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showTimePicker) {
                            if #available(iOS 16.0, *) {
                                VStack {
                                    DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.wheel)
                                        .padding()
                                    
                                    Button("Done") {
                                        showTimePicker = false
                                    }
                                    .padding(.top, 10)
                                }.presentationDetents([.medium])
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }
                }
//                .padding(.vertical, 10)
//                .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Note")
                        .font(.customfont(.medium, fontSize: 14))
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $note)
                            .font(.customfont(.medium, fontSize: 12))
                            .foregroundColor(.gray)
                            .frame(height: 80)
                            .cornerRadius(10)
                            .padding(4)
//                            .background(Color(.systemGray6))
                            
                        if note.isEmpty {
                            Text("Enter any note here....")
                                .font(.customfont(.light, fontSize: 12))
                                .foregroundColor(.gray)
                                .padding(12)
                        }
                    }
                }
                
                // Button
                Button(action: { print("Schedule Booking") }) {
                    Text("Schedule Booking")
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color.colorNeavyBlue)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
                
            } // MAIN VSTACK
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 11)
                .stroke(Color.gray, lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6)))
            )
            .padding(.horizontal, 16)
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

#Preview {
    ScheduleBookingView()
}
