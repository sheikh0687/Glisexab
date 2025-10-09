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
    @StateObject private var locationManager = LocationManager()
    @State private var showMoreDetail: Bool = false
    
    @State private var showCancelPopup = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: MAP VIEW
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: TOP BAR
            VStack(spacing: 0) {
                TopBarView(showBack: false)
                Spacer()
            }
            
            // MARK: ADDRESS VIEW
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
                        Text("1901 Thornridge Cir. Shiloh, Hawaii 81063 Indore 456789")
                            .font(.customfont(.medium, fontSize: 12))
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text("2 min away")
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
            .padding(.vertical, 60)
            
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
                        Text("Your driver is arriving  in 2 minute")
                            .font(.customfont(.medium, fontSize: 16))
                        Spacer()
                        
                        Button {
                            print("Edit Address")
                        } label: {
                            Image("editAddress")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding()
                    
                    // Vehicle and Driver Detail
                    HStack {
                        Image("profileEdit")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
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
                            Image("luxury")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 120)
                            
                            Spacer()
                            
                            VStack(spacing: 4) {
                                Text("Luxury")
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
                            
                            Text("1901 Thornridge Cir. Shiloh, Hawaii 81063")
                                .font(.customfont(.medium, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 18))

                            Text("2715 Ash Dr. San Jose, South Dakota 83475")
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
    }
}

#Preview {
    TrackingView()
}
