//
//  PopupBargainView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/10/25.
//

import SwiftUI

struct PopupBargainView: View {
    
    @Binding var isShowing: Bool
    @State private var txtBidPrice: String = ""
    
    @EnvironmentObject private var router: NavigationRouter
    
    var strPrice: String = "$150"
    var isComingFrom: String
    
    var body: some View {
        
        if isComingFrom == "Booking Detail" {
            VStack(alignment: .center, spacing: 20) {
                
                Text("Bargain with Driver")
                    .font(.customfont(.medium, fontSize: 16))
                Text("You can propose a fare to the driver. Skip if you want system fare.")
                    .font(.customfont(.regular, fontSize: 14))
                    .multilineTextAlignment(.center)
                Text("Estimate Fare: \(strPrice)")
                    .font(.customfont(.medium, fontSize: 12))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter your offer")
                        .font(.customfont(.medium, fontSize: 14))
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $txtBidPrice)
                            .font(.customfont(.medium, fontSize: 12))
                            .foregroundColor(.gray)
                            .padding(4)
                            .background(Color.clear)
                            .frame(height: 80)
                            .cornerRadius(10)
                            
                            
                        if txtBidPrice.isEmpty {
                            Text("Enter Ride fare according you")
                                .font(.customfont(.light, fontSize: 12))
                                .foregroundColor(.gray)
                                .padding(12)
                        }
                    }
                    .background(Color(.systemGray6)) // apply background here
                    .cornerRadius(10)
                }

                // Button
                Button(action: {
//                    router.push(to: .trackDriver)
                }) {
                    Text("Send")
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.colorNeavyBlue)
                        .cornerRadius(12)
                }
                
                Button(action: {
//                    router.push(to: .trackDriver)
                }) {
                    Text("Skip")
                        .font(.customfont(.bold, fontSize: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
            } // MAIN VSTACK
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 11)
                .stroke(Color.gray, lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.white)))
            )
            .padding(.horizontal, 40)

        } else {
            VStack(alignment: .center, spacing: 40) {
                
                VStack(spacing: 0) {
                    Text("Are you sure you want to cancel this ride? ")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Text("A cancellation fee may apply.")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                HStack {
                    Button(action: { print("Schedule Booking") }) {
                        Text("Yes, I want")
                            .font(.customfont(.bold, fontSize: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { print("Schedule Booking") }) {
                        Text("Cancel")
                            .font(.customfont(.bold, fontSize: 14))
                            .foregroundColor(.colorNeavyBlue)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                }
                // Button
                
            } // MAIN VSTACK
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 11)
                .stroke(Color.gray, lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.white)))
            )
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    PopupBargainView(isShowing: .constant(false), isComingFrom: "Booking Detail")
}
