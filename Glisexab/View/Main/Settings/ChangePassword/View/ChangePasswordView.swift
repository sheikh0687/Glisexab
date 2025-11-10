//
//  ChangePasswordView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/11/25.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject var viewModel = ChangePasswordViewModel()
    @State private var showSuccessBanner: Bool = false
    @State private var showErrorBanner: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                
                SecureField("Current Password", text: $viewModel.currentPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                SecureField("New Password", text: $viewModel.newPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.leading, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                Button {
                    viewModel.requestChangePassword(appState: appState)
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                    } else {
                        Text("Update")
                            .font(.customfont(.bold, fontSize: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.colorNeavyBlue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                                
                Spacer()
            }
            .padding()
            .padding(.top, 20)
            
            if showErrorBanner, let error = viewModel.customError {
                CustomErrorBanner(message: error.localizedDescription) {
                    withAnimation {
                        showErrorBanner = false
                        viewModel.customError = nil
                    }
                }
                .animation(.easeInOut, value: showErrorBanner)
                .padding(.top, 8)
            }
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
        .onChange(of: viewModel.isSuccess) { success in
            if success {
                showSuccessBanner = true
            }
        }
        .alert(isPresented: $showSuccessBanner) {
            Alert(
                title: Text(Constant.AppName),
                message: Text("Your password has been changed successfully."),
                dismissButton: .default(Text("ok")) {
                    router.popView()
                }
            )
        }
        .onChange(of: viewModel.customError) { error in
            withAnimation {
                showErrorBanner = error != nil
            }
        }
    }
}

//#Preview {
//    ChangePasswordView()
//}
