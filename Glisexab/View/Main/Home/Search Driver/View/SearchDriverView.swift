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
    @EnvironmentObject private var appState: AppState
    
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    
    @StateObject var searchViewModel = SearchDriverViewModel()
    @ObservedObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        
        ZStack(alignment: .top) {
            // BOTTOM FLOATING CARD
            CustomMapView (
                region: $viewModel.region,
                annotations: makeAnnotations(),
                routes: viewModel.route.map { [$0] } ?? [] )
            
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
            
            viewModel.updateRoute()
            startProgressTimer(searchViewModel: searchViewModel, appState: appState)
        }
        .onDisappear {
            timer?.invalidate()
        }
        .onChange(of: searchViewModel.isSuccess) { isSuccessfull in
            if isSuccessfull {
                print("Successfully requst fethced!!")
                if let obj = searchViewModel.obj_Res {
                    if obj.status == "Pending" {
                        router.push(to: .trackDriver)
                    }
                }
            }
        }
    }
    
    func startProgressTimer(searchViewModel: SearchDriverViewModel, appState: AppState) {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            progress += 0.01
            if progress >= 1.0 {
                timer?.invalidate()
            }
            DispatchQueue.main.async {
                searchViewModel.userActiveRequest(appState: appState)
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

#Preview {
    SearchDriverView(viewModel: .init())
        .environmentObject(NavigationRouter())
        .environmentObject(AppState())
}
