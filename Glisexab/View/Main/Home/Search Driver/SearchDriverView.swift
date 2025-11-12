//
//  SearchDriverView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/10/25.
//

import SwiftUI
import MapKit

struct SearchDriverView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @ObservedObject var viewModel: LocationSearchViewModel
        
    @State private var progress: CGFloat = 0.45

    var body: some View {
        ZStack(alignment: .top) {
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
            print("SearchDriverView appeared")
            print("Pickup coordinate: \(viewModel.pickupCoordinate?.latitude ?? 0), \(viewModel.pickupCoordinate?.longitude ?? 0)")
            print("Dropoff coordinate: \(viewModel.dropoffCoordinate?.latitude ?? 0), \(viewModel.dropoffCoordinate?.longitude ?? 0)")
            
            if let pickup = viewModel.pickupCoordinate {
                viewModel.region.center = pickup
            }
        }
    }
    
    func makeAnnotations() -> [MKPointAnnotation] {
        var result: [MKPointAnnotation] = []
        if let pickup = viewModel.pickupCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = pickup
            ann.title = "Pickup"
            result.append(ann)
        }
        if let drop = viewModel.dropoffCoordinate {
            let ann = MKPointAnnotation()
            ann.coordinate = drop
            ann.title = "Drop-off"
            result.append(ann)
        }
        return result
    }
}

//#Preview {
//    SearchDriverView()
//}
