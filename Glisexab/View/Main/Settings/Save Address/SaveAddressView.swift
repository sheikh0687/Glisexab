//
//  SaveAddressView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct SavedAddress: Identifiable {
    let id = UUID()
    let type: String
    let address: String
}

struct SaveAddressView: View {
    
    @State private var arrayOfSavedAddress: [SavedAddress] = [
        SavedAddress(type: "Home", address: "1901 Thornridge Cir. Shiloh, Hawaii, 1901 Thornridge Cir. Shiloh, Hawaii"),
        SavedAddress(type: "Office", address: "1901 Thornridge Cir. Shiloh, Hawaii")
    ]
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                ForEach(arrayOfSavedAddress.indices, id: \.self) { indexx in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(arrayOfSavedAddress[indexx].type)
                                .font(.customfont(.medium, fontSize: 16))
                            Text(arrayOfSavedAddress[indexx].address)
                                .font(.customfont(.regular, fontSize: 14))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        HStack {
                            Button {
                                print("Edit address")
                            } label: {
                                Image("edit")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 24, height: 24)
                            }
                            
                            Button {
                                print("Edit address")
                            } label: {
                                Image("delete")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 14)
                    .frame(minHeight: 100)
                    .background (
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .overlay (
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 16)
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
//            .padding(.vertical, 10)
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
            }

        }
    }
}

#Preview {
    SaveAddressView()
}
