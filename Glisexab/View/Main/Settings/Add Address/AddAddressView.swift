//
//  AddAddressViw.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 10/10/25.
//

import SwiftUI

struct AddAddressView: View {
    
    @State private var txtAddressTitle: String = ""
    @State private var txtStreet:String = ""
    @State private var txtCity:String = ""
    @State private var txtPincode:String = ""
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        optionRow(heading: "Address Title", text: $txtAddressTitle, placeholder: "Address Title ex: Home")
                        
                        optionRow(heading: "Street", text: $txtStreet, placeholder: "Enter Street")

                        optionRow(heading: "City", text: $txtCity, placeholder: "Enter city")

                        optionRow(heading: "Pincode", text: $txtPincode, placeholder: "Enter Pincode")
                        
                        Button("Save") {
                            // Edit action
                        }
                        .font(.customfont(.bold, fontSize: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.colorNeavyBlue)
                        .foregroundColor(.white)
                        .cornerRadius(8)

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
    }
    
    @ViewBuilder
    func optionRow(heading: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(heading)
                .font(.customfont(.semiBold, fontSize: 14))
                .foregroundColor(.black)
            VStack {
                TextField(placeholder, text: text)
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
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

#Preview {
    AddAddressView()
}
