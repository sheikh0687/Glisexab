//
//  DriverDetailView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 08/10/25.
//

import SwiftUI

struct RiderReview: Identifiable {
    let id = UUID()
    let avatar: String
    let name: String
    let comment: String
    let rating: Double
}

struct DriverDetailView: View {
    
    let reviews = [
        RiderReview(avatar: "leslie", name: "Leslie Alexander", comment: "Thankyou !! I am reached on time.", rating: 4.8),
        RiderReview(avatar: "jenny", name: "Jenny Wilson", comment: "Thankyou !! for Safe drive.", rating: 4.9)
    ]
    
    @EnvironmentObject private var router: NavigationRouter

    var body: some View {
        ZStack {
            // 1. Background image fills entire screen
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // 2. All foreground content stacks above
            VStack(spacing: 0) {
                // Top header with rounded bottom
                ZStack() {
                    Rectangle()
                        .fill(Color.colorNeavyBlue)
                        .frame(height: 180)
//                        .ignoresSafeArea(.container, edges: .top)
                }
                .frame(height: 350)
                
                // Overlapping profile image
                Image("profileEdit")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 4)
                    .padding(.top, -140)
                
                if #available(iOS 16.4, *) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 10) {
                            
                            Text("Jerome Bell")
                                .font(.customfont(.semiBold, fontSize: 16))
                            
                            // Stat cards row
                            HStack(spacing: 20) {
                                VStack(spacing: 8) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "car.fill")
                                            .foregroundColor(.colorNeavyBlue)
                                            .font(.system(size: 24, weight: .bold))
                                        Text("2.5K+")
                                            .font(.customfont(.medium, fontSize: 14))
                                            .foregroundColor(.colorNeavyBlue)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 70)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 1)
                                    Text("Rides")
                                        .font(.customfont(.semiBold, fontSize: 14))
                                }
                                VStack(spacing: 8) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.colorNeavyBlue)
                                            .font(.system(size: 24, weight: .bold))
                                        Text("4.9")
                                            .font(.customfont(.medium, fontSize: 14))
                                            .foregroundColor(.colorNeavyBlue)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 70)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 1)
                                    Text("Rating")
                                        .font(.customfont(.semiBold, fontSize: 14))
                                }
                                
                                VStack(spacing: 8) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "briefcase.fill")
                                            .foregroundColor(.colorNeavyBlue)
                                            .font(.system(size: 24, weight: .bold))
                                        Text("2.6")
                                            .font(.customfont(.medium, fontSize: 14))
                                            .foregroundColor(.colorNeavyBlue)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 70)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 1)
                                    Text("Years")
                                        .font(.customfont(.semiBold, fontSize: 14))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.top, 20)
                            
                            // Sedan and info section
                            Image("sedan")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            
                            // Model and ID row
                            HStack {
                                Text("Model :")
                                    .font(.customfont(.semiBold, fontSize: 18))
                                    .foregroundColor(.gray)
                                Text("Sedan")
                                    .font(.customfont(.semiBold, fontSize: 18))
                                    .foregroundColor(.black)
                                Spacer()
                                Text("4873")
                                    .font(.customfont(.semiBold, fontSize: 16))
                                    .padding()
                                    .frame(height: 30)
                                    .foregroundColor(.white)
                                    .background(Color.colorNeavyBlue)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            // Safety message
                            Text("Your safety is our priority - Always verify the license plate and the driver's identity before entering the vehicle.")
                                .font(.customfont(.regular, fontSize: 16))
                                .padding()
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Riders Review")
                                    .font(.customfont(.semiBold, fontSize: 16))
                                Divider()
                                    .padding(.top, 2)
                                
                                ForEach(reviews) { reviews in
                                    HStack(spacing: 12) {
                                        Image(reviews.avatar)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(reviews.name)
                                                .font(.customfont(.semiBold, fontSize: 14))
                                            Text(reviews.comment)
                                                .font(.customfont(.regular, fontSize: 14))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            //                                    .font(.system(size: 12))
                                            Text("4.8")
                                                .font(.customfont(.regular, fontSize: 14))
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            Spacer().frame(height: 120)
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .scrollBounceBehavior(.basedOnSize)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
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

#Preview {
    DriverDetailView()
}
