//
//  SettingView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 09/10/25.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @EnvironmentObject private var appState: AppState
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        VStack {
                            HStack(spacing: 20) {
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
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(viewModel.firstName) \(viewModel.lastName)")
                                        .font(.customfont(.bold, fontSize: 16))
                                    Button {
                                        router.push(to: .editProfile)
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
                                optionRow(image: "userProfile24", text: "Edit Profile", action: {
                                    router.push(to: .editProfile)
                                })
                                optionRow(image: "saveAddress24", text: "Save Address", action: {
                                    router.push(to: .saveAddress)
                                })
                                optionRow(image: "invite24", text: "Invite Friends", action: {
                                    print("Navigate")
                                })
                                optionRow(image: "password24", text: "Change Password", action: {
                                    router.push(to: .changePassword)
                                })
                                optionRow(image: "privacy24", text: "Privacy Policy", action: {
                                    print("Navigate")
                                })
                                optionRow(image: "support24", text: "Support", action: {
                                    print("Navigate")
                                })
                                optionRow(image: "logout24", text: "Logout", action: {
                                    router.popToRoot()
                                    appState.isLoggedIn = false
                                })
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
            .padding(.top, 40)
            .ignoresSafeArea(edges: .bottom)
        } // ZSTACK
        .navigationTitle("Profile")
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
            viewModel.fetchUserProfile(appState: appState)
        }
    }
    
    @ViewBuilder
    func optionRow(image: String, text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
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
                    .overlay (
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Outer stroke border
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingView()
}
