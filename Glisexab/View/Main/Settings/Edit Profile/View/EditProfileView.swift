//
//  EditProfileView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI
import CountryPicker

struct EditProfileView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject var appState: AppState
    
    @State private var showCameraPicker = false
    @State private var showCountryPicker = false
    @State private var showErrorBanner = false
    
    @State private var countryObj: Country?
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        profileImageView
                        formFields
                        updateButton
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white)
                } // Scrool View
            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .padding(.top, 40)
            .ignoresSafeArea(edges: .bottom)
            
//            if viewModel.isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: Color.colorNeavyBlue))hksdhfklsdjflsdjfsdhjflksdhfiuhfkm  hkhjkhsdlfhj
//                    .scaleEffect(1.5)
//                    .background(Color.black.opacity(0.25).ignoresSafeArea())
//            }
            
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
        } // ZSTACK
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.selectedUIImage = image
            }
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            if countryObj == nil {
                countryObj = Country(phoneCode: "91", isoCode: "IN")
            }
            // Update ViewModel mobileCode when countryObj changes
            if let countryObj = countryObj {
                viewModel.mobileCode = "\(countryObj.phoneCode)"
            }
            viewModel.fetchUserProfile(appState: appState)
        }
    }
    
    private var profileImageView: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let uiImage = viewModel.selectedUIImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Image("leslie")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            }
            
            Image("edit")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(6)
                .background(.white)
                .cornerRadius(12)
                .shadow(radius: 2)
        }
        .onTapGesture {
            showCameraPicker = true
        }
        .onChange(of: viewModel.customError) { newError in
            withAnimation {
                showErrorBanner = newError != nil
            }
        }
    }
    
    private var formFields: some View {
        VStack(spacing: 20) {
            optionRow(heading: "First Name", text: $viewModel.firstName)
            optionRow(heading: "Last Name", text: $viewModel.lastName)
            optionRow(heading: "Email", text: $viewModel.email)
            optionRow(heading: "Contact Number", text: $viewModel.contactNumber)
        }
    }
    
    private var updateButton: some View {
        Button("Update Profile") {
            viewModel.cloUpdateProfile = {
                print("Update profile success closure called")
                AlertManager.shared.showAlert (
                    title: Constant.AppName,
                    message: "Your profile updated successfully!",
                    primaryButtonText: "Ok",
                    primaryAction: {
                        viewModel.fetchUserProfile(appState: appState)
                    }
                )
            }
            viewModel.updateUserProfile(appState: appState)
        }
        .font(.customfont(.bold, fontSize: 16))
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.colorNeavyBlue)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
    
    @ViewBuilder
    func optionRow(heading: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.customfont(.medium, fontSize: 12))
                .foregroundColor(.gray)
            HStack {
                if heading == "Contact Number" {
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
                    TextField("", text: text)
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                    
                } else {
                    TextField("", text: text)
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .background (
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.white))
                .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Outer stroke border
                )
        )
    }
}

#Preview {
    EditProfileView()
}
