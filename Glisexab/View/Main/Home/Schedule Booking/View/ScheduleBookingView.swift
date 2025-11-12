//
//  ScheduleBookingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/10/25.
//

import SwiftUI

struct ScheduleBookingView: View {
    
    @State private var showDatePicker: Bool = false
    
    @State private var showTimePicker: Bool = false
    
    @EnvironmentObject private var router: NavigationRouter
    @StateObject var viewModel: ScheduleBookingViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                //MARK: TOP BAR
                
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Date")
                                .font(.customfont(.medium, fontSize: 14))
                            Button {
                                showDatePicker = true
                            } label: {
                                Text(viewModel.formattedDate)
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
                                        DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
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
                                Text(viewModel.formattedTime)
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
                                        DatePicker("Select Time", selection: $viewModel.selectedTime, displayedComponents: .hourAndMinute)
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Note")
                            .font(.customfont(.medium, fontSize: 14))
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $viewModel.note)
                                .font(.customfont(.medium, fontSize: 12))
                                .foregroundColor(.gray)
                                .frame(height: 80)
                                .cornerRadius(10)
                                .padding(4)
    //                            .background(Color(.systemGray6))
                                
                            if viewModel.note.isEmpty {
                                Text("Enter any note here....")
                                    .font(.customfont(.light, fontSize: 12))
                                    .foregroundColor(.gray)
                                    .padding(12)
                            }
                        }
                    }
                    
                    // Button
                    Button(action: {
                        viewModel.schedule()
                        router.popView()
                    }) {
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
//            .ignoresSafeArea()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
}

//#Preview {
//    ScheduleBookingView(viewModel: <#ScheduleBookingViewModel#>)
//}
