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
            
            let tabs = [("home", "Home"), ("chat", "Chat"), ("history", "History"), ("profile", "Profile")]
            
            var body: some View {
                    ZStack(alignment: .top) {
                            
                            // Background Map
                            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                                .ignoresSafeArea()
                            
                            VStack(spacing: 0) {
                                    
                                    // Top Bar
                                    TopBarView(
                                            showBack: false,
                                                rightButtonImage: "schedule",
                                                rightButtonAction: { print("Schedule tapped") }
                                        )
                                        .padding(.bottom, 12)
                                    
                                    // MARK: Search Card
                                    VStack(spacing: 20) {
                                            
                                            HStack {
                                                    Image(systemName: "mappin.and.ellipse")
                                                    Text("Elgin St. Celina, Delaware 10299")
                                                        .font(.customfont(.light, fontSize: 14))
                                                    Spacer()
                                                }
                                                .padding(.top, 12)
                                            
                                            Divider()
                                            
                                            TextField("To Where", text: .constant(""))
                                                .padding(.vertical, 8)
                                                    .padding(.horizontal, 8)
                                                        .background(Color(.systemGray6))
                                                            .cornerRadius(6)
                                                                .padding(.bottom, 10)
                                            
                                            Button {
                                                    print("Book Ride")
                                                } label: {
                                                        Text("Book Trip")
                                                            .font(.customfont(.bold, fontSize: 14))
                                                                .foregroundColor(.white)
                                                                    .frame(maxWidth: .infinity)
                                                                        .frame(height: 45)
                                                                            .background(Color.colorNeavyBlue)
                                                                                .cornerRadius(10)
                                                    }
                                                    .padding(.vertical, 20)
                                        }
                                        .padding(.horizontal, 16)
                                            .background(Color.white)
                                                .cornerRadius(20)
                                                    .shadow(radius: 5)
                                    
                                    Spacer()
                                    
                                    // MARK: Bottom Navigation Bar
                                    HStack(spacing: 20) {
                                            ForEach(tabs.indices, id: \.self) { index in
                                                    VStack {
                                                            Image(tabs[index].0)
                                                                .resizable()
                                                                    .scaledToFit()
                                                                        .frame(width: 36, height: 36)
                                                            Text(tabs[index].1)
                                                                .font(.customfont(.medium, fontSize: 16))
                                                                    .foregroundColor(.colorNeavyBlue)
                                                        }
                                                        .frame(width: 80, height: 80)
                                                            .background(Color.white)
                                                                .cornerRadius(8)
                                                                    .overlay(
                                                                            RoundedRectangle(cornerRadius: 8)
                                                                                    .stroke(selectedTab == index ? Color.blue : Color.clear, lineWidth: 3)
                                                                        )
                                                                        .shadow(radius: 4)
                                                                            .onTapGesture { selectedTab = index }
                                                }
                                        }
                                        .padding(.vertical, 20)
                                            .padding(.horizontal, 24)
                                                .background(Color.colorNeavyBlue)
                                                    .cornerRadius(20)
                                                        .shadow(radius: 10)
                                                            .padding(.horizontal, 16)
                                }
                        }
                }
        }
    
#Preview {

        HomeView()
 }
