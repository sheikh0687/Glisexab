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
    
    @State var isLoading: Bool = false
    @State var customError: CustomError? = nil
    @State var showErrorBanner = false
    @State var showSuccessBanner = false
    
    @State var isPasswordReset: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("Reset Password")
                    .font(.customfont(.medium, fontSize: 18))
                    .padding(.leading)
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Enter your valid\nemail address")
                        .font(.customfont(.regular, fontSize: 22))
                        .padding(.leading, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Text("Email Address")
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
                            Image("mail")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(.leading, 12)
                            
                            TextField("Enter valid email", text: $txtMobileNumber)
                                .font(.customfont(.light, fontSize: 14))
                                .padding(.leading, 4)
                        }
                    }
                    
                    Button {
                        resetPassword()
                    } label: {
                        if isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.white)
                                .cornerRadius(10)
                        } else {
                            Text("Send")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.colorNeavyBlue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 40)
                }
                .padding()
                
                Spacer()
            }// VSTACK
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            
            if showErrorBanner, let error = customError {
                CustomErrorBanner(message: error.localizedDescription) {
                    withAnimation {
                        showErrorBanner = false
                        customError = nil
                    }
                }
                .animation(.easeInOut, value: showErrorBanner)
                .padding(.top, 8)
            }
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
        .onChange(of: customError) { newError in
            withAnimation {
                showErrorBanner = newError != nil
            }
        }
        .onChange(of: isPasswordReset) { isSuccess in
            if isSuccess {
                showSuccessBanner = true
            }
        }
        .alert(isPresented: $showSuccessBanner) {
            Alert(
                title: Text(Constant.AppName),
                message: Text("Your new password has been sent to your mail."), dismissButton: .default(Text("ok")) {
                    router.popView()
                })
        }
    }
}

extension ForgetPasswordView {
    
    func resetPassword() {
        
        guard !txtMobileNumber.isEmpty else {
            return customError = .customError(message: "Please enter the valid email address.")
        }
        
        isLoading = true
        customError = nil
        
        let params = ["email": txtMobileNumber] // Pass your actual params
        
        print(params)
        
        Api.shared.requestToForgetPassword(params: params) { result in
            
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    if response.status == "1" {
                        isPasswordReset = true
                    } else {
                        customError = .customError(message: response.result ?? "")
                    }
                case .failure(let error):
                    customError = .customError(message: error.localizedDescription)
                    print("❌ API Error:", error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ForgetPasswordView()
}
