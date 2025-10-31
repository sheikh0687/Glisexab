//
//  SignupView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI
import CountryPicker

struct SignupView: View {
    
    // MARK: PROPERTY
    @State private var txtFirstName: String = ""
    @State private var txtLastName: String  = ""
    @State private var txtEmail: String = ""
    @State private var txtContactNumber: String = ""
    @State private var txtAddress: String = ""
    @State private var txtPassword: String = ""
    @State private var txtConfirmPassword: String = ""
    
    @State private var isCheck = false
    @State private var isPaswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var countryObj: Country?
    @State private var showCountryPicker = false
    @State private var showAddressPicker = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dissmiss
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = SignupViewModel()
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    
                    Text("Continue to Signup")
                        .font(.customfont(.medium, fontSize: 18))
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("First Name")
                            .font(.customfont(.medium, fontSize: 14))
                            .padding(.leading, 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 45)
                                .cornerRadius(10)
                                .overlay     (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 0.8)
                                )
                            
                            HStack {
                                Image("user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                TextField("Enter First Name", text: $txtFirstName)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                        }
                        
                        Text("Last Name")
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
                                Image("user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                TextField("Enter Last Name", text: $txtLastName)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                        }
                        
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
                                
                                TextField("Enter Email Address", text: $txtEmail)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                        }
                        
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
                                            .padding(.leading, 12)
                                        
                                        Text("+\(countryObj.phoneCode)")
                                            .font(.customfont(.medium, fontSize: 16))
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                TextField("Enter Contact Number", text: $txtContactNumber)
                                    .font(.customfont(.light, fontSize: 14))
                                    .padding(.leading, 4)
                            }
                            
                        }
                        
                        Text("Location")
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
                                Image("Location")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 12)
                                
                                Button {
                                    showAddressPicker = true
                                } label: {
                                    Text(viewModel.address ?? "Select Address")
                                        .font(.customfont(.light, fontSize: 14))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 4)
                                }
                            }
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
                                
                                if isPaswordVisible {
                                    TextField("Enter Password", text: $txtPassword)
                                        .font(.customfont(.light, fontSize: 14))
                                        .padding(.leading, 4)
                                } else {
                                    SecureField("Enter Password", text: $txtPassword)
                                        .font(.customfont(.light, fontSize: 14))
                                        .padding(.leading, 4)
                                }
                                
                                Spacer()
                                
                                Button {
                                    isPaswordVisible.toggle()
                                } label: {
                                    Image(isPaswordVisible ? "Password" : "Unlock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .padding(.trailing, 12)
                                }
                            }
                        }
                        
                        Text("Confirm Password")
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
                                
                                if isConfirmPasswordVisible {
                                    TextField("Confirm Password", text: $txtConfirmPassword)
                                        .font(.customfont(.light, fontSize: 14))
                                        .padding(.leading, 4)
                                } else {
                                    SecureField("Confirm Password", text: $txtConfirmPassword)
                                        .font(.customfont(.light, fontSize: 14))
                                        .padding(.leading, 4)
                                }
                                
                                Spacer()
                                
                                Button {
                                    isConfirmPasswordVisible.toggle()
                                } label: {
                                    Image(isConfirmPasswordVisible ? "Password" : "Unlock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .padding(.trailing, 12)
                                }
                            }
                        }
                        
                        HStack() {
                            Button {
                                isCheck.toggle()
                            } label: {
                                Image(isCheck ? "checked" : "uncheck")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Button {
                                print("")
                            } label: {
                                Text("By Signing up you agree to our ")
                                    .font(.customfont(.light, fontSize: 14))
                                    .foregroundColor(.gray)
                                +
                                Text("Terms & Conditions")
                                    .font(.customfont(.bold, fontSize: 14))
                                    .foregroundColor(.colorNeavyBlue)
                            }
                            .buttonStyle(.plain)
                            .padding(.leading, 10)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    Button {
                        Task {
                            viewModel.firstName = txtFirstName
                            viewModel.lastName = txtLastName
                            viewModel.email = txtEmail
                            viewModel.password = txtPassword
                            viewModel.confirmPassword = txtConfirmPassword
                            viewModel.mobile = txtContactNumber
                            viewModel.mobileCode = countryObj?.phoneCode ?? ""
                            await viewModel.signUp()
                            if viewModel.newUser != nil {
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
                            Text("Signup")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color.colorNeavyBlue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
                    HStack {
                        Text("Have an Account?")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.gray)
                        Button("Sign in") {
                            
                        }
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.colorNeavyBlue)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                }// VSTACK
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color.white)
                .navigationBarBackButtonHidden(true)
            }
        } // ZSTACk
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
        .sheet(isPresented: $showAddressPicker) {
            NavigationView {
                addressView()
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addressView() -> some View {
        let addressViewModel = AddressSearchViewModel()
        addressViewModel.delegate = self
        return AnyView(AddressPickerView(searchViewModel: addressViewModel))
    }
}

extension SignupView: Address {
    func didSelectAddress(result: Result<LocationData, LocationError>) {
        switch result {
        case .success(let result):
            viewModel.address = result.address ?? ""
            viewModel.city = result.city ?? ""
            viewModel.state = result.state ?? ""
            viewModel.latitude = result.latitude ?? 0.0
            viewModel.longitude = result.longitude ?? 0.0
        case .failure(let error):
            //            $viewModel.error = .customError(message: error.localizedDescription)
            print(error.localizedDescription)
        }
    }
}

#Preview {
    SignupView()
}
