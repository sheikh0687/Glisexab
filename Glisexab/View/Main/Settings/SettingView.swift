//
//  SettingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 09/10/25.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        ZStack {
            Color.colorNeavyBlue
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        VStack {
                            HStack(spacing: 20) {
                                Image("leslie")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Leslie Alexander")
                                        .font(.customfont(.bold, fontSize: 16))
                                    Button {
                                        print("Navigate to profile view")
                                    } label: {
                                        Text("View Profile")
                                            .font(.customfont(.regular, fontSize: 16))
                                            .foregroundColor(.black)
                                            .underline()
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .background (
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                        )

                        VStack {
                            VStack(spacing: 10) {
                                optionRow(image: "userProfile24", text: "Edit Profile")
                                optionRow(image: "saveAddress24", text: "Save Address")
                                optionRow(image: "invite24", text: "Invite Friends")
                                optionRow(image: "password24", text: "Change Password")
                                optionRow(image: "privacy24", text: "Privacy Policy")
                                optionRow(image: "support24", text: "Support")
                                optionRow(image: "logout24", text: "Logout")
                            }
                            .padding()
                        }
                        .padding(.vertical, 10)
                        .background (
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                        )
                    }
                    .padding(.horizontal, 14)
                }
            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .ignoresSafeArea(edges: .bottom)
        } // ZSTACK
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
    }
    
    @ViewBuilder
    func optionRow(image: String, text: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(text)
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 10)
            .background (
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Outer stroke border
                    )
            )
        }
    }
    
    private var backButton: some View {
        Button {
            print("Navigate to back")
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SettingView()
}
