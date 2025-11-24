//
//  BookingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/10/25.
//

import SwiftUI
import SDWebImageSwiftUI
internal import Combine

struct BookingView: View {
    
    //MARK: PROPERTIES
    @State private var showingPopup = false
    @State private var showErrorBanner = false
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = BookingDetailViewModel()
    
    @State private var cancellables = Set<AnyCancellable>()
    
    //MARK: MAIN BODY
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    //MARK: TOP HEADER
                    topHeader
                    //MARK: Booking for other
                    bookingForOtherSection
                    Divider()
                    
                    //MARK: Vehicle for booking
                    vehicleListSection
                    Divider()
                    
                    //MARK: Card Payment
                    paymentMethodSection
                }
                .padding(.horizontal, 10)// MAIN VSTACK
            }// SCROL VIEW
            
            //            if showingPopup {
            //                Color.black.opacity(0.4)
            //                    .ignoresSafeArea()
            //                    .onTapGesture {
            //                        withAnimation { showingPopup = false }
            //                    }
            //                // Your Popup Content
            //                PopupBargainView(isShowing: $showingPopup, isComingFrom: "Booking Detail")
            //                    .transition(.scale)
            //                    .zIndex(1)
            //            }
        }
        //        .animation(.easeInOut, value: showingPopup)
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
            viewModel.fetchSaveCard(appState: appState)
        }
        .onChange(of: viewModel.isSuccessBooked) { isSuccess in
            if isSuccess {
                let pickupCoord = viewModel.data?.pickup.locationCoordinate()
                let dropoffCoord = viewModel.data?.dropoff.locationCoordinate()

                let locationSearchVM = LocationSearchViewModel()
                locationSearchVM.pickupCoordinate = pickupCoord
                locationSearchVM.dropoffCoordinate = dropoffCoord
                
                router.push(to: .searchDriver(locationSearchVM))
            }
        }
        .onChange(of: viewModel.customError) { newError in
            if newError != nil {
                showErrorBanner = true
            }
        }
        .alert(isPresented: $showErrorBanner) {
            Alert (
                title: Text(Constant.AppName),
                message: Text(viewModel.customError?.localizedDescription ?? "Something went wrong!"),
                dismissButton: .default(Text("Ok")) {
                    withAnimation {
                        viewModel.customError = nil
                    }
                }
            )
        }
        
    } // ZSTACK
    
    var topHeader: some View {
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
                    Text(viewModel.data?.pickup.address ?? "")
                        .font(.customfont(.medium, fontSize: 14))
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Dropoff Address")
                        .font(.customfont(.regular, fontSize: 13))
                        .foregroundColor(.gray)
                    Text(viewModel.data?.dropoff.address ?? "")
                        .font(.customfont(.medium, fontSize: 14))
                }
            }
            .padding(.leading, 4)
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue, lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
        )
        .padding(12)
        .padding(.top, 20)
    }
    
    var bookingForOtherSection: some View {
        VStack(alignment: .leading) {
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
                    viewModel.isBookingForOther.toggle()
                } label: {
                    Image(viewModel.isBookingForOther ? "checked" : "uncheck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .padding()
            if viewModel.isBookingForOther {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Someone Name")
                        .font(.customfont(.regular, fontSize: 12))
                    TextField("Enter here..", text: $viewModel.otherName)
                        .padding()
                        .font(.customfont(.light, fontSize: 12))
                        .frame(height: 45)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("Contact Number")
                        .font(.customfont(.regular, fontSize: 12))
                    TextField("Enter here..", text: $viewModel.otherMobile)
                        .padding()
                        .font(.customfont(.light, fontSize: 12))
                        .frame(height: 45)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding()
                Divider()
            }
        }
    }
    
    var vehicleListSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rides Available")
                .font(.customfont(.medium, fontSize: 14))
                .padding(.horizontal, 10)
            
            if viewModel.isLoading {
                ProgressView("Loading vehicle...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else if viewModel.vehicleList.isEmpty {
                Text("No rides available.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(viewModel.vehicleList) { vehicle in
                    RideRow(vehicle: vehicle, selected: vehicle.id == viewModel.selectedVehcileIndex)
                        .onTapGesture {
                            withAnimation {
                                viewModel.selectedVehcileIndex = vehicle.id
                            }
                            viewModel.vehicleiD = vehicle.vehicleId ?? ""
                            viewModel.vehicleName = vehicle.vehicle ?? ""
                            viewModel.distance = vehicle.distance ?? ""
//                            viewModel.dateTime = vehicle.date_time ?? ""
                            viewModel.fairEstimate = vehicle.estimate_fair ?? ""
                        }
                }
                .animation(.easeInOut, value: viewModel.selectedVehcileIndex)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color(.systemBackground))
    }
    
    var paymentMethodSection: some View {
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
                if viewModel.isLoading {
                    ProgressView("Loading Cards...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else if viewModel.savedCardList.isEmpty {
                    Text("No saved cards available.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(viewModel.savedCardList) { card in
                        CardRow(cardList: card, isSelected: card.id == viewModel.selectedCardId)
                            .onTapGesture {
                                viewModel.selectedCardId = card.id
                                viewModel.cardId = card.cardId ?? ""
                            }
                    }
                }
                Spacer()
                bookingButtonsSection
            }
            .padding(.horizontal, 10)
        }
    }
    
    var bookingButtonsSection: some View {
        VStack(spacing: 14) {
            Button {
                viewModel.requestAddNearbyReq(appState: appState, bookingType: "Now", scheduleDate: "", scheduleTime: "", description: "")
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.white)
                        .cornerRadius(10)
                } else {
                    Text("Book Now")
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 45)
                        .background(Color.colorNeavyBlue)
                        .cornerRadius(10)
                }
            }
            
            Button {
                let scheduleBookingVM = ScheduleBookingViewModel()
                
                router.push(to: .scheduleBooking(scheduleBookingVM))
                
                scheduleBookingVM.$didScheduleBooking
                    .sink { isScheduled in
                        if isScheduled {
                            // Handle schedule success here
                            viewModel.requestAddNearbyReq(appState: appState, bookingType: "Later", scheduleDate: scheduleBookingVM.formattedDate, scheduleTime: scheduleBookingVM.formattedTime, description: scheduleBookingVM.note)
                        }
                    }
                    .store(in: &cancellables)
            } label: {
                Text("Schedule Booking")
                    .font(.customfont(.bold, fontSize: 14))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .background(Color.colorNeavyBlue)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
    }
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
    BookingView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
