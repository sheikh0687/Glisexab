//
//  BookingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/10/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct RideOption: Identifiable {
    let id = UUID()
    let imageName: String   // Use asset name (for dynamic, use URL type)
    let title: String
    let description: String
    let price: String
    var isSelected: Bool = false
}

struct PaymentCard: Identifiable {
    let id = UUID()
    let type: String
    let maskedNumber: String
}

struct BookingView: View {
    
    //MARK: PROPERTIES
    @State private var txtSomeOther: String = ""
    @State private var txtContactNumber: String = ""
    
    @State private var isBookingForOther: Bool = false
    
    var arrayOfRides:[RideOption] = [
        RideOption(imageName: "hundai", title: "Hyundai | mini", description: "4 Person | 2 Bags", price: "$120"),
        RideOption(imageName: "sedan", title: "Sedan", description: "4 Person | 2 Bags", price: "$150"),
        RideOption(imageName: "luxury", title: "Luxury", description: "4 Person | 2 Bags", price: "$170"),
        RideOption(imageName: "suv", title: "SUV", description: "4 Person | 2 Bags", price: "$190"),
        RideOption(imageName: "twoWheeler", title: "Bike", description: "4 Person | 2 Bags", price: "$80"),
        RideOption(imageName: "threeWheeler", title: "Tricycle", description: "4 Person | 2 Bags", price: "$60")
    ]
    
    @State private var selectedVehcileIndex = 0
    
    @State private var arrayOfCards = [
        PaymentCard(type: "Credit Card", maskedNumber: ".....5755"),
        PaymentCard(type: "Credit Card", maskedNumber: ".....5755")
    ]
    
    @State private var selectedCardIndex = 0
    @State private var showingPopup = false
    
    @EnvironmentObject private var router: NavigationRouter
    
    var data: BookingDetailData
    
    @StateObject var viewModel = BookingDetailViewModel()
    @EnvironmentObject var appState: AppState
    
    //MARK: MAIN BODY
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    //MARK: TOP HEADER
                    HStack(alignment: .top, spacing: 8) {
                        VStack(spacing: 4) {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .font(.system(size: 16))
                            
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                .frame(width: 2, height: 28)
                                .foregroundColor(.green)
                            
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 16))
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Pickup Address")
                                    .font(.customfont(.regular, fontSize: 13))
                                    .foregroundColor(.gray)
                                Text(data.pickup.address)
                                    .font(.customfont(.medium, fontSize: 14))
                            }
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Dropoff Address")
                                    .font(.customfont(.regular, fontSize: 13))
                                    .foregroundColor(.gray)
                                Text(data.dropoff.address)
                                    .font(.customfont(.medium, fontSize: 14))
                            }
                        }
                        .padding(.leading, 4)
                        Spacer()
                    } // HSTACK
                    .padding(12)
                    .background (
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 0.5)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
                    )
                    .padding(12)
                    .padding(.top, 20)
                    
                    
                    //MARK: Booking for other
                    HStack(spacing: 2) {
                        Image("booking")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("Is this booking for someone else?")
                            .font(.customfont(.medium, fontSize: 16))
                            .foregroundColor(.black)
                            .padding(.horizontal, 6)
                        
                        Spacer()
                        Button {
                            isBookingForOther.toggle()
                        } label: {
                            Image(isBookingForOther ? "checked" : "uncheck")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    if isBookingForOther {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Someone Name")
                                .font(.customfont(.regular, fontSize: 12))
                            TextField("Enter here..", text: $txtSomeOther)
                                .padding()
                                .font(.customfont(.light, fontSize: 12))
                                .frame(height: 45)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            
                            Text("Contact Number")
                                .font(.customfont(.regular, fontSize: 12))
                            TextField("Enter here..", text: $txtSomeOther)
                                .padding()
                                .font(.customfont(.light, fontSize: 12))
                                .frame(height: 45)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        Divider()
                    }
                    
                    //MARK: Vehicle for booking
                    
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Rides Available")
//                            .font(.customfont(.medium, fontSize: 14))
//                            .padding(.horizontal, 10)
//                        
//                        if viewModel.isLoading {
//                            ProgressView("Loading vehicle...")
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding()
//                        } else if viewModel.vehicleList.isEmpty {
//                            Text("No rides available.")
//                                .foregroundColor(.gray)
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .padding()
//                        } else {
//                            ForEach(Array(viewModel.vehicleList.enumerated()), id: \.offset) { indexx, vehicle in
//                                HStack(spacing: 8) {
//                                    
//                                    WebImage(url: URL(string: vehicle.image ?? ""))
//                                        .placeholder {
//                                            Rectangle().fill(Color.gray.opacity(0.3))
//                                        }
//                                        .resizable()
//                                        .indicator(.activity)
//                                        .frame(width: 60, height: 36)
//                                        .cornerRadius(8)
//    
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(vehicle.vehicle ?? "Unknown Vehicle")
//                                            .font(.customfont(.medium, fontSize: 12))
//                                        Text(vehicle.no_of_passenger ?? "No passanger")
//                                            .font(.customfont(.regular, fontSize: 10))
//                                            .foregroundColor(Color.gray)
//                                    }
//                                    
//                                    Spacer()
//                                    Text(vehicle.per_km_price ?? "")
//                                        .font(.customfont(.medium, fontSize: 14))
//                                }
//                                .padding(.vertical, 12)
//                                .padding(.horizontal, 10)
//                                .background (
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .stroke(indexx == selectedVehcileIndex ? Color.colorLightBlue : Color(.systemGray6), lineWidth: 1)
//                                        .background (
//                                            indexx == selectedVehcileIndex ? Color(.systemGray6) : Color.white
//                                        )
//                                )
//                                .onTapGesture {
//                                    selectedVehcileIndex = indexx
//                                }
//                                .animation(.easeInOut, value: selectedVehcileIndex)
//                            }
//                            .cornerRadius(15)
//                        }
//                    } // VSTACK
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 10)
//                    .background(Color(.systemBackground))
                    
                    Divider()
                    
                    //MARK: Card Payment
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Select Payment Method")
                                .font(.customfont(.medium, fontSize: 14))
                            Spacer()
                            Button {
                                print("Navigate to card selection")
                            } label: {
                                Text("Add Card")
                                    .font(.customfont(.bold, fontSize: 10))
                                    .foregroundColor(Color.white)
                                    .frame(width: 80, height: 28)
                                    .background(Color.colorNeavyBlue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        VStack(spacing: 16) {
                            ForEach(arrayOfCards.indices, id: \.self) { card in
                                HStack(spacing: 4) {
                                    
                                    Text(arrayOfCards[card].type)
                                        .font(.customfont(.medium, fontSize: 14))
                                    Text(arrayOfCards[card].maskedNumber)
                                        .font(.customfont(.medium, fontSize: 14))
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Circle()
                                            .stroke(selectedCardIndex == card ? Color.black : Color.black, lineWidth: 2)
                                            .frame(width: 24, height: 24)
                                        if selectedCardIndex == card {
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width: 12, height: 12)
                                        }
                                    }
                                }
                                .padding(14)
                                .background (
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(selectedCardIndex == card ? Color.blue : Color(.systemGray6), lineWidth: 1)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white)
                                        )
                                )
                                .onTapGesture {
                                    selectedCardIndex = card
                                }
                            }
                            
                            Spacer()
                            
                            //MARK: Booking Now And Schedule
                            
                            VStack(spacing: 14) {
                                Button {
                                    showingPopup = true
                                } label: {
                                    Text("Book Now")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, minHeight: 45)
                                        .background(Color.colorNeavyBlue)
                                        .cornerRadius(10)
                                }
                                
                                Button {
                                    router.push(to: .scheduleBooking)
                                } label: {
                                    Text("Schedule Booking")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, minHeight: 45)
                                        .background(Color.colorNeavyBlue)
                                        .cornerRadius(10)
                                }
                            }
                        } // BOTTOM VSTACK
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                        //                        .padding(.bottom, 40)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 10)// MAIN VSTACK
            }// SCROL VIEW
            
            if showingPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showingPopup = false }
                    }
                // Your Popup Content
                PopupBargainView(isShowing: $showingPopup, isComingFrom: "Booking Detail")
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showingPopup)
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
            viewModel.fetchVehicleList(appState: appState)
        }
    } // ZSTACK
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

#Preview {
    BookingView(data: BookingDetailData(
        pickup: LocationDetail(address: "123 Main St", latitude: 12.34, longitude: 56.78),
        dropoff: LocationDetail(address: "789 Park Ave", latitude: 98.76, longitude: 54.32)
    ))
}
