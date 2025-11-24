//
//  TrackingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/10/25.
//

import SwiftUI
import MapKit

struct TrackingView: View {
    
    // MARK: PROPERTY
    @StateObject var locationManager = LocationSearchViewModel()
    @State private var showMoreDetail: Bool = false
    @State private var showCancelPopup = false
    @State private var showRideDetails = false
    @State private var showDriverDetails = false
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject var viewModel = SearchDriverViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: MAP VIEW
            CustomMapView (
                region: $locationManager.region,
                annotations: makeAnnotations(),
                routes: locationManager.route.map { [$0] } ?? [] )
            
            // MARK: Top ADDRESS VIEW
            VStack(alignment: .leading) {
                HStack {
                    Image("locationRed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pickup Address")
                            .font(.customfont(.bold, fontSize: 14))
                        Text(viewModel.obj_Res?.pick_address ?? "")
                            .font(.customfont(.medium, fontSize: 12))
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text("\(viewModel.obj_Res?.distance_away ?? "") min away")
                                .font(.customfont(.medium, fontSize: 12))
                                .foregroundColor(.colorGreen)
                            Spacer()
                            Button {
                                print("Edit the selected address")
                            } label: {
                                Image("edit")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding()
                }
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white))
                        .ignoresSafeArea(edges: .bottom)
                )
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            
            // MARK: BOTTOM VIEW
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    // Driver Timing
                    HStack {
                        Button {
                            showMoreDetail.toggle()
                        } label: {
                            Image(showMoreDetail ? "openView" : "closeView")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        Spacer()
                        Text("Your driver is arriving in \(viewModel.obj_Res?.distance ?? "") minute")
                            .font(.customfont(.medium, fontSize: 16))
                        Spacer()
                        
                        Menu {
                            Button {
                                router.push(to: .rideDetails)
                            } label: {
                                Text("Ride Details")
                                    .font(.customfont(.medium, fontSize: 14))
                            }
                            
                            Button {
                                router.push(to: .driverDetails)
                            } label: {
                                Text("Driver Details")
                                    .font(.customfont(.medium, fontSize: 14))
                            }
                        } label : {
                            Image("editAddress")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                    
                    // Vehicle and Driver Detail
                    HStack {
                        if let uiImage = viewModel.profileImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        } else {
                            Image("profileEdit")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        }
                        Spacer().frame(width: 10)
                        VStack(spacing: 6) {
                            Text("Jerome Bell")
                                .font(.customfont(.medium, fontSize: 14))
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(Font.system(size: 14))
                                
                                Text("4.8 (9)")
                                    .font(.customfont(.regular, fontSize: 14))
                            }
                        }
                        Spacer()
                        Divider()
                            .frame(width: 1, height: 70)
                            .foregroundColor(Color.black)
                        Spacer()
                        VStack(spacing: 6) {
                            Text("$150.00")
                                .font(.customfont(.medium, fontSize: 14))
                            Text("Estimate")
                                .font(.customfont(.regular, fontSize: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button {
                                print("Call")
                            } label: {
                                Image("call")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            }
                            
                            Button {
                                print("Call")
                            } label: {
                                Image("fillChat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    // Vehicle Detail
                    if showMoreDetail {
                        HStack {
                            if let uiImage = viewModel.vehcileImage{
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140, height: 120)
//                                    .clipShape(Circle())
                            } else {
                                Image("luxury")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140, height: 120)
//                                    .clipShape(Circle())
                            }

                            Spacer()
                            
                            VStack(spacing: 4) {
                                Text(viewModel.obj_Res?.car_details?.vehicle ?? "")
                                    .font(.customfont(.medium, fontSize: 16))
                                    .foregroundColor(.gray)
                                Text("4786")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        
                        Divider()
                    }
                    
                    // Pick And Drop Address
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .font(.system(size: 18))
                            
                            Text(viewModel.obj_Res?.pick_address ?? "")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))
                            
                            Text(viewModel.obj_Res?.drop_address ?? "")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.top, 16)
                    
                    // Cancel Button
                    HStack {
                        Button {
                            showCancelPopup = true
                        } label: {
                            Text("Cancel Ride")
                                .font(.customfont(.bold, fontSize: 14))
                                .foregroundColor(.red)
                                .frame(minWidth: 120, minHeight: 40)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.red, lineWidth: 1) // 👈 border color & width
                                )
                                .cornerRadius(12)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white))
                        .ignoresSafeArea(edges: .bottom)
                )
                .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            if showCancelPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showCancelPopup = false }
                    }
                    .zIndex(0)
                
                // Your Popup Content
                PopupBargainView(isShowing: $showCancelPopup, isComingFrom: "Driver Detail")
                    .transition(.scale)
                    .zIndex(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        } // ZSTACK
        .animation(.easeInOut, value: showCancelPopup)
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
            viewModel.userActiveRequest(appState: appState)
        }
        .onChange(of: viewModel.isSuccess) { isSuccess in
            if isSuccess {
                if let obj = viewModel.obj_Res {
                    if let pickLat = Double(obj.pickup_lat ?? ""),
                       let pickLon = Double(obj.pickup_lon ?? ""),
                       let dropLat = Double(obj.dropoff_lat ?? ""),
                       let dropLon = Double(obj.dropoff_lon ?? "") {
                        
                        let pickupCoord = CLLocationCoordinate2D(latitude: pickLat, longitude: pickLon)
                        let dropoffCoord = CLLocationCoordinate2D(latitude: dropLat, longitude: dropLon)
                        
                        locationManager.pickupCoordinate = pickupCoord
                        locationManager.dropoffCoordinate = dropoffCoord
                    } else {
                        print("Invalid coordinates received")
                    }
                }
            }
        }
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var result: [MKPointAnnotation] = []
        if let pickup = locationManager.pickupCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = pickup
            ann.title = "Pickup"
            result.append(ann)
        }
        if let drop = locationManager.dropoffCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = drop
            ann.title = "Drop-off"
            result.append(ann)
        }
        return result
    }
    
}

#Preview {
    TrackingView()
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
