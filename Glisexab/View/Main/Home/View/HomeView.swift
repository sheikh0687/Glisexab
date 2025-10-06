//
//  HomeView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

//import SwiftUI
//import MapKit
//
//struct HomeView: View {
//
//    @StateObject var pickupVM = SearchCompleterViewModel()
//    @StateObject var dropVM = SearchCompleterViewModel()
//
//    @State private var pickupAddress = ""
//    @State private var dropupAddress = ""
//    @State private var pickupCordinate: CLLocationCoordinate2D?
//    @State private var dropCordinate: CLLocationCoordinate2D?
//    @State private var activeField: ActiveField?
//
//    @StateObject private var locationManager = LocationManager()
//    @State private var selectedTab: Int = 0
//
//    let tabs = [("home", "Home"), ("chat", "Chat"), ("history", "History"), ("profile", "Profile")]
//
//    enum ActiveField {
//        case pickup
//        case drop
//    }
//
//    var body: some View {
//
//        ZStack(alignment: .top) {
//            // Background Map
//            Map(coordinateRegion: $locationManager.region, annotationItems: mapAnnotations) { place in
//                MapPin(coordinate: place.coordinate)
//            }
//            .edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 0) {
//                // Top Bar
//                TopBarView (
//                    showBack: false,
//                    rightButtonImage: "schedule",
//                    rightButtonAction: { print("Schedule tapped") }
//                )
//
//                // MARK: Search Card
//                VStack(spacing: 0) {
//
//                    HStack(spacing: 8) {
//                        Image(systemName: "mappin.and.ellipse")
//                        Text("Elgin St. Celina, Delaware 10299")
//                            .font(.customfont(.light, fontSize: 14))
//                        Spacer()
//                    }
//                    .padding(.top, 16)
//
//                    Divider()
//                        .padding(.horizontal, 12)
//                        .padding(.top, 12)
//
//                    TextField("To Where", text: .constant(""))
//                        .padding(.vertical, 10)
//                        .padding(.horizontal, 8)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .padding(.top, 12)
//
//
//                    //                    TextField("Pickup address", text: $pickupAddress, onEditingChanged: { editing in activeField = editing ? .pickup : nil })
//                    //                        .onChange(of: pickupAddress) { pickupVM.queryFragment = $0 }
//                    //                        .padding()
//                    //                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
//                    //                    if activeField == .pickup && !pickupVM.results.isEmpty {
//                    //                        addressListVM(pickupVM) { completion in
//                    //                            resolve(completion) { coord, name in
//                    //                                pickupAddress = name
//                    //                                pickupCordinate = coord
//                    //                                activeField = nil
//                    //                                updateMapRegion()
//                    //                            }
//                    //                        }
//                    //                    }
//                    // Drop Field
//                    //                    TextField("Drop address", text: $dropupAddress, onEditingChanged: {editing in activeField = editing ? .drop : nil })
//                    //                        .onChange(of: dropupAddress) { dropVM.queryFragment = $0 }
//                    //                        .padding()
//                    //                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
//                    //                    if activeField == .drop && !dropVM.results.isEmpty {
//                    //                        addressListVM(dropVM) { completion in
//                    //                            resolve(completion) { coord, name in
//                    //                                dropupAddress = name
//                    //                                dropCordinate = coord
//                    //                                activeField = nil
//                    //                                updateMapRegion()
//                    //                            }
//                    //                        }
//                    //                    }
//                }
////                .background(Color.white)
////                .cornerRadius(16)
////                .shadow(radius: 5)
////                .padding()
//                //                Spacer()
//                //
//                //
//
//                Button {
//                    print("Book Ride")
//                } label: {
//                    Text("Book Trip")
//                        .font(.customfont(.bold, fontSize: 14))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 45)
//                        .background(Color.colorNeavyBlue)
//                        .cornerRadius(10)
//                        .padding(.top, 14)
//                        .padding(.bottom, 14)
//                }
//            }
//            .padding(.horizontal, 20)
//            .background(Color.white)
//            .cornerRadius(16)
//            .shadow(radius: 5)
//            .frame(maxWidth: 350)
//            .padding(.top, 20)
//
//            Spacer()
//
//            // MARK: Bottom Navigation Bar
//            HStack(spacing: 10) {
//                ForEach(tabs.indices, id: \.self) { index in
//                    VStack(spacing: 4) {
//                        Image(tabs[index].0)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 32, height: 32)
//                        Text(tabs[index].1)
//                            .font(.customfont(.medium, fontSize: 14))
//                            .foregroundColor(.colorNeavyBlue)
//                    }
//                    .frame(width: 70, height: 70)
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(selectedTab == index ? Color.blue : Color.clear, lineWidth: 3)
//                    )
//                    .shadow(radius: 2)
//                    .onTapGesture { selectedTab = index }
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .center)
//            .padding(.vertical, 12)
//            .background(Color.colorNeavyBlue)
//            .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
//        }
//        .ignoresSafeArea()
//        .frame(maxWidth: .infinity, alignment: .top)
//    }
//
//    // Annotations
//    var mapAnnotations: [MapLocation] {
//        [pickupCordinate, dropCordinate]
//            .compactMap { $0 }
//            .map { MapLocation(coordinate: $0) }
//    }
//
//    func addressListVM(_ vm: SearchCompleterViewModel, select: @escaping (MKLocalSearchCompletion) -> Void) -> some View {
//        VStack(spacing: 0) {
//            ForEach(vm.results, id: \.self) { suggestion in
//                VStack(alignment: .leading) {
//                    Text(suggestion.title)
//                        .font(.subheadline)
//                    if !suggestion.subtitle.isEmpty {
//                        Text(suggestion.subtitle)
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }
//                .padding(8)
//                .onTapGesture { select(suggestion) }
//                Divider()
//            }
//        }
//        .background(Color.white)
//        .cornerRadius(8)
//        .shadow(radius: 4)
//        .padding(.horizontal, 6)
//    }
//
//    // Resolves MKLocalSearchCompletion result to coordinate and name
//    func resolve(_ completion: MKLocalSearchCompletion, completionHandler: @escaping (CLLocationCoordinate2D, String) -> Void) {
//        let req = MKLocalSearch.Request(completion: completion)
//        let search = MKLocalSearch(request: req)
//        search.start { resp, _ in
//            if let item = resp?.mapItems.first {
//                completionHandler(item.placemark.coordinate, item.placemark.title ?? item.name ?? "")
//            }
//        }
//    }
//
//    // Adjusts map to show both markers
//    func updateMapRegion() {
//        if let pick = pickupCordinate, let drop = dropCordinate {
//            let minLat = min(pick.latitude, drop.latitude)
//            let minLon = min(pick.longitude, drop.longitude)
//            let maxLat = max(pick.latitude, drop.latitude)
//            let maxLon = max(pick.longitude, drop.longitude)
//            locationManager.region = .init(
//                center: .init(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2),
//                span: .init(latitudeDelta: max(0.02, maxLat - minLat + 0.02), longitudeDelta: max(0.02, maxLon - minLon + 0.02))
//            )
//        }
//    }
//}
//
//struct MapLocation: Identifiable {
//    let id = UUID()
//    var coordinate: CLLocationCoordinate2D
//}
//
//#Preview {
//    HomeView()
//}

import SwiftUI
import _MapKit_SwiftUI

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedTab: Int = 0
    @State private var destination: String = ""
    
    let tabs = [("home", "Home"), ("chat", "Chat"), ("history", "History"), ("profile", "Profile")]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Full background map
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Top Bar with padding for notch
                TopBarView(
                    showBack: false,
                    rightButtonImage: "schedule",
                    rightButtonAction: { print("Schedule tapped") }
                )
                //                .padding(.top, 20)
//                .padding(.horizontal, 24)
                
                // Floating search card
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.blue)
                        Text("Elgin St. Celina, Delaware 10299")
                            .font(.customfont(.light, fontSize: 14))
                        Spacer()
                    }
                    .padding(.top, 16)
                    
                    TextField("To where", text: $destination)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.top, 12)
                    
                    Button {
                        print("Book Ride")
                    } label: {
                        Text("Book Trip")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.colorNeavyBlue)
                            .cornerRadius(10)
                            .padding(.top, 14)
                            .padding(.bottom, 14)
                    }
                }
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.09), radius: 8, x: 0, y: 4)
                .frame(maxWidth: 350)
                .padding(.bottom, 12)
                
                Spacer()
                
                // Bottom Navigation
                
                HStack(spacing: 10) {
                    ForEach(tabs.indices, id: \.self) { index in
                        VStack(spacing: 4) {
                            Image(tabs[index].0)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                            Text(tabs[index].1)
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.colorNeavyBlue)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedTab == index ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .shadow(radius: 2)
                        .onTapGesture { selectedTab = index }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
                .background(Color.colorNeavyBlue)
                .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
            }
        }
    }
}

#Preview {
    HomeView()
}
