//
//  SearchDriverView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/10/25.
//

import SwiftUI
import MapKit

struct SearchDriverView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var progress: CGFloat = 0.45

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                TopBarView(showBack: false)
                Spacer()
            }
            
            // BOTTOM FLOATING CARD
            VStack {
                Spacer()
                VStack(spacing: 40) {
                    Text("Searching Drivers around you")
                        .font(.customfont(.medium, fontSize: 16))
                        .padding(.top, 40)
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                            .frame(height: 10)
                            .foregroundColor(Color(.systemGray4))
                        Capsule()
                            .frame(width: 240 * progress, height: 10)
                            .foregroundColor(.colorNeavyBlue)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                
                .background (
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white))
                        .ignoresSafeArea(edges: .bottom)
                )
                .edgesIgnoringSafeArea(.bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    SearchDriverView()
}
