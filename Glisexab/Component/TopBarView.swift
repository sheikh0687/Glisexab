//
//  TopBarView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/10/25.
//

import SwiftUI

struct TopBarView: View {
    @Environment(\.dismiss) var dismiss
    
    var showBack: Bool = true   // 👈 optional back button
    var logoName: String = "SplashLogo"
    var rightButtonImage: String? = nil  // optional right button image
    var rightButtonAction: (() -> Void)? = nil // optional action
    
    var body: some View {
        ZStack {
            Color.colorNeavyBlue
                .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                .frame(height: .screenHeight * 0.150)
            
            HStack {
                // Back Button
                if showBack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.top, 30)
                    }
                }
                
                Spacer()
                
                // Center Logo
                if showBack {
                    Image(logoName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: .screenHeight * 0.1)
                        .padding(.top, 30)
                }
                
//                Spacer()
                
//                 👈 Optional right side button (if you want later)
//                 Button(action: { print("Right button tapped") }) {
//                     Image(systemName: "gear")
//                         .resizable()
//                         .scaledToFit()
//                         .frame(width: 30, height: 30)
//                         .foregroundColor(.white)
//                 }
//                
//                Button(action: { print("Right button tapped") }) {
//                    Image(systemName: "gear")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
//                }
                
                if let rightImage = rightButtonImage, let action = rightButtonAction {
                    Button(action: action) {
                        Image(rightImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    VStack {
        TopBarView(showBack: true)   // With back
        Spacer()
        TopBarView(showBack: false)  // Without back
    }
}
