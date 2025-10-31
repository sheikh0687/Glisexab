//
//  LoginView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 01/10/25.
//

import SwiftUI
import CountryPicker

struct LoginView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dissmiss
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = LoginViewModel()
    
    @State private var txtContactNumber: String = ""
    @State private var txtPassword: String = ""
    @State private var mobileCode: String = ""
    @State private var countryObj: Country?
    @State private var showCountryPicker = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Continue to Sign in")
                        .font(.customfont(.medium, fontSize: 18))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
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
                                
                                Button {
                                    showCountryPicker = true
                                } label: {
                                    
                                    if let countryObj = countryObj {
                                        Text("\(countryObj.isoCode.getFlag())")
                                            .font(.customfont(.medium, fontSize: 28))
                                        
                                        Text("+\(countryObj.phoneCode)")
                                            .font(.customfont(.medium, fontSize: 16))
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                TextField("Enter Contact Number", text: $txtContactNumber)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                            .padding()
                        }
                        
                        Text("Password")
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
                                Image("Password")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                SecureField("Enter Password", text: $txtPassword)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                                
                                Spacer()
                                
                                Image("Unlock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 12)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        Button("Forget Password?") {
                            router.push(to: .forgetPassword)
                        }
                        .font(.customfont(.semiBold, fontSize: 14))
                        .foregroundColor(.colorNeavyBlue)
                        .padding(.trailing, 24)
                    }
                    .padding(.top, 15)
                    
                    Button {
                        guard !txtContactNumber.isEmpty, !txtPassword.isEmpty else {
                            viewModel.errorMessage = "Please fill all required fields."
                            return
                        }
                        Task {
                            viewModel.mobile = txtContactNumber
                            viewModel.password = txtPassword
                            viewModel.mobileCode = countryObj?.phoneCode ?? ""
                            await viewModel.login()
                            if viewModel.user != nil {
                                router.push(to: .home)
                                appState.isLoggedIn = true
                            }
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.white)
                                .cornerRadius(10)
                        } else {
                            Text("Signin")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.colorNeavyBlue)
                                .cornerRadius(10)
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .alert (
                        viewModel.errorMessage ?? "",
                        isPresented: Binding (
                            get: { viewModel.errorMessage != nil },
                            set: { if !$0 { viewModel.errorMessage = nil }}
                        ),
                        actions: { Button("OK", role: .cancel) { viewModel.errorMessage = nil } }
                    )
                    
                    HStack {
                        Text("Don’t have an Account?")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.gray)
                        Button("Sign up") {
                            router.push(to: .signup)
                        }
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.colorNeavyBlue)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }// VSTACK
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color.white)
                
                
            }//SCROOLVIEW
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
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
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
    }
}

#Preview {
    LoginView()
}
