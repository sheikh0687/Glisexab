//
//  WelcomeView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/09/25.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    Color(.colorLightBlue)
                        .ignoresSafeArea(.all, edges: .all)
                    
                    ScrollView {
                        VStack(alignment: .center) {
                            HStack {
                                Text("Welcome to")
                                    .font(.customfont(.regular, fontSize: 24))
                                    .foregroundColor(.gray)
                                Text("Glisexab")
                                    .font(.customfont(.bold, fontSize: 24))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 20)
                            
                            Image("WelcomeTaxi")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 500)
                            
                            Text("""
                            Your trusted ride booking partner 
                            for safe, fast, and reliable trips.
                            """)
                            .font(.customfont(.medium, fontSize: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            
                            NavigationLink {
                                OnboardingView()
                            } label: {
                                Text("Get Started")
                                    .font(.customfont(.bold, fontSize: 16))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(25)
                            .padding(.top, 20)
                        }
                        .padding()
                    }// SCROLLVIEW
                }// ZSTACK
            }// NavigationSTACK
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}
