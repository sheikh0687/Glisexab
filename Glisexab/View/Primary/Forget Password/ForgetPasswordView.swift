//
//  ForgetPasswordView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var txtMobileNumber: String = ""
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                Text("Reset Password")
                    .font(.customfont(.medium, fontSize: 18))
                    .padding(.leading)
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Enter your registered\nmobile number")
                        .font(.customfont(.regular, fontSize: 22))
                        .padding(.leading, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Text("Contact Number")
                        .font(.customfont(.medium, fontSize: 14))
                        .padding(.leading, 4)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 45)
                            .cornerRadius(10)
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                            )
                        
                        HStack {
                            Image("Contact")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(.leading, 12)
                            
                            TextField("Enter Registered Number", text: $txtMobileNumber)
                                .font(.customfont(.light, fontSize: 14))
                                .padding(.leading, 4)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Send OTP")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 40)
                }
                .padding()
                
                Spacer()
                
            }// VSTACK
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                        router.popView()
                    }
                }
                
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
    ForgetPasswordView()
}
