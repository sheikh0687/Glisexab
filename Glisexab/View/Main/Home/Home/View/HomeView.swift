//
//  HomeView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var selectedTab: Int = 0
    @State private var destination: String = ""
    
    let tabs = [("home", "Home"), ("chat", "Chat"), ("history", "History"), ("profile", "Profile")]
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack(alignment: .top) {
            // Full background map
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {

                // Floating search card
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                        Text("Elgin St. Celina, Delaware 10299")
                            .font(.customfont(.light, fontSize: 14))
                        Spacer()
                    }
                    .padding(.top, 16)
                    
                    TextField("To where", text: $destination)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.top, 12)
                    
                    Button {
                        router.push(to: .bookingDetails)
                    } label: {
                        Text("Book Trip")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(10)
                            .padding(.top, 14)
                            .padding(.bottom, 14)
                    }
                }
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.09), radius: 8, x: 0, y: 4)
                .frame(maxWidth: 350)
                .padding(.bottom, 12)
                
                Spacer()
                
                // Bottom Navigation
                
                HStack(spacing: 10) {
                    ForEach(tabs.indices, id: \.self) { index in
                        VStack(spacing: 4) {
                            Image(tabs[index].0)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                            Text(tabs[index].1)
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.colorNeavyBlue)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedTab == index ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .shadow(radius: 2)
                        .onTapGesture {
                            selectedTab = index
                            if index == 0 {
                                print("Home Tab")
                                router.push(to: .home)
                            } else if index == 1 {
                                print("Chat Tab")
                            } else if index == 2 {
                                print("History Tab")
                                router.push(to: .history)
                            } else {
                                print("Profile Tab")
                                router.push(to: .settings)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .background(Color.colorNeavyBlue)
                .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomLogo()
                        .frame(width: 100, height: 120)
                }
            }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
}

#Preview {
    HomeView()
}
