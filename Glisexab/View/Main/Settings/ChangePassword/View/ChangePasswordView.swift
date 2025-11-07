//
//  ChangePasswordView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/11/25.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @StateObject var viewModel = ChangePasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                
                TextField("Current Password", text: $viewModel.currentPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                TextField("New Password", text: $viewModel.newPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                TextField("Confirm Password", text: $viewModel.confirmPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                
                Button("Update") {
                    print("Call Api")
                }
                .font(.customfont(.bold, fontSize: 16))
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundColor(.white)
                .background(.colorNeavyBlue)
                .cornerRadius(10)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .padding(.top, 20)
        }
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
}

#Preview {
    ChangePasswordView()
}
