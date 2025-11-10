//
//  AddAddressViw.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct AddAddressView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @State private var showAddressPicker = false
    @State private var showErrorBanner = false
    @State private var showSuccessBanner = false
    
    @StateObject var viewModel = AddAddressViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        optionRow(heading: "Address", text: $viewModel.address, placeholder: "Address")
                        
                        optionRow(heading: "Type", text: $viewModel.addressType, placeholder: "Address Type ex: Home")
                        
                        Button {
                            viewModel.addUserAddress(appState: appState)
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            } else {
                                Text("Save")
                                    .font(.customfont(.bold, fontSize: 16))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.colorNeavyBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding()
                    .background (
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                }// ScroolView
            }
            
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
        } // Zstack
        .navigationTitle("Add Address")
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
        .sheet(isPresented: $showAddressPicker) {
            NavigationView {
                addressView()
            }
            .interactiveDismissDisabled()
        }
        .onChange(of: viewModel.customError) { error in
            withAnimation {
                showErrorBanner = error != nil
            }
        }
        .onChange(of: viewModel.isSuccess) { isSuccess in
           if isSuccess {
                showSuccessBanner = true
            }
        }
        .alert(isPresented: $showSuccessBanner) {
            Alert (
                title: Text(Constant.AppName),
                message: Text("Your Address Added Successfully"),
                dismissButton: .default(Text("ok")) {
                    router.popView()
                })
        }
    }
    
    private func addressView() -> some View {
        let addressViewModel = AddressSearchViewModel()
        addressViewModel.delegate = self
        return AnyView(AddressPickerView(searchViewModel: addressViewModel))
    }
    
    @ViewBuilder
    func optionRow(heading: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.customfont(.semiBold, fontSize: 14))
                .foregroundColor(.black)
            VStack {
                if heading == "Address" {
                    Button {
                        showAddressPicker = true
                    } label: {
                        Text(viewModel.address)
                            .font(.customfont(.light, fontSize: 14))
                            .foregroundColor(viewModel.address.isEmpty ? .gray : .black)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 4)
                    }
                    .padding(.vertical, 8)
                } else {
                    TextField(placeholder, text: text)
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
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
                    .frame(height: 50)
            )
        }
    }
}

extension AddAddressView: Address {
    
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
    AddAddressView()
}
