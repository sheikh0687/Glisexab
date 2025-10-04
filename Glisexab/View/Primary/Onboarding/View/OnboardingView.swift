//
//  OnboardingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/10/25.
//

import SwiftUI

struct OnboardingItem {
    let imageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    
    let onboardingData: [OnboardingItem] = [
        .init(imageName: "Slide1", title: "Track your driver in real-time", description: "See your driver’s location, estimated arrival time, and ride status live."),
        .init(imageName: "Slide2", title: "Book your ride in just a few taps", description: "Set pickup & drop location, choose your ride type, and confirm instantly."),
        .init(imageName: "Slide3", title: "Your safety is our priority", description: "Verified drivers, SOS option, and 24/7 support for worry-free rides.")
    ]
    
    @State private var currentPage = 0
    @State private var navigateNext = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    // Background color
                    Color.colorNeavyBlue
                        .ignoresSafeArea()
                    
                    // TabView with white rounded background on each page
                    TabView(selection: $currentPage) {
                        ForEach(onboardingData.indices, id: \.self) { index in
                            VStack(alignment: .leading) {
                                Image(onboardingData[index].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .screenWidth * 0.85)
                                    .padding(.top, 20)
                                
                                Text(onboardingData[index].title)
                                    .font(.customfont(.bold, fontSize: 18))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 40)
                                
                                Text(onboardingData[index].description)
                                    .font(.customfont(.medium, fontSize: 16))
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                
                                Spacer()
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .tag(index)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeOut, value: currentPage)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack {
                        Spacer()
                        HStack {
                            // Page Indicator
                            HStack(spacing: 8) {
                                ForEach(0..<onboardingData.count, id: \.self) { index in
                                    Circle()
                                        .fill(index == currentPage ? Color.colorNeavyBlue : Color.gray)
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 24)
                            
                            Spacer()
                            
                            // Next Button Overlay
                            ZStack {
                                // Blue arc cut effect
                                Circle()
                                    .fill(Color.colorNeavyBlue)
                                    .frame(width: 120, height: 120) // slightly bigger for effect
                                    .offset(x: 40) // pushes half outside
                                    .overlay {
                                        Button {
                                            withAnimation {
                                                if currentPage < onboardingData.count - 1 {
                                                    currentPage += 1
                                                } else {
                                                    navigateNext = true
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.system(size: 22, weight: .bold))
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                            }
                            .padding(.trailing, -20) // aligns with edge
                            .padding(.bottom, 24)
                        }
                    }
                    
                    NavigationLink(destination: LoginView(), isActive: $navigateNext) {
                        EmptyView()
                    }
                }
            }// NAVIGATION STACK
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()

        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    OnboardingView()
}
