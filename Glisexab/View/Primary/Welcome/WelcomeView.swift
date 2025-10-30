//
//  WelcomeView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/09/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        
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
                    .padding(.top, 60)
                    
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
                    
                    Button {
                        router.push(to: .onboarding)
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
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        
//        if #available(iOS 16.0, *) {
//            NavigationStack {
//                
//            }// NavigationSTACK
//        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(NavigationRouter())
}
