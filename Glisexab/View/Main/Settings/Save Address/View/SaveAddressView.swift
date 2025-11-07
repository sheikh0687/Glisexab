//
//  SaveAddressView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct SaveAddressView: View {
        
    @EnvironmentObject private var router: NavigationRouter
    @StateObject private var viewModel = SaveAddressViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else if viewModel.arrayOfAddress.isEmpty {
                    Text("No Address available.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(viewModel.arrayOfAddress) { addressList in
                        SaveAddressRow(addressRow: addressList) {
                            viewModel.deleteUserSavedAddress(appState: appState, addressiD: addressList.id ?? "")
                            viewModel.cloDeleteAddres = {
                                viewModel.fetchSavedAddressList(appState: appState)
                            }
                        }
                    }
                }
                
                Button("Add Address") {
                    router.push(to: .addAddress)
                }
                .font(.customfont(.medium, fontSize: 16))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.colorNeavyBlue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal, 16)
                
            } // VSTACK
            .padding(.top, 20)
            .padding(.horizontal, 10)
            .background(Color(.systemBackground))
            .navigationTitle("Save Address")
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
                viewModel.fetchSavedAddressList(appState: appState)
            }
        }
    }
}
