//
//  HomeView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/10/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = LocationSearchViewModel()
    @State private var selectedTab: Int = 0
    @State private var showSuggestions = false
    @State private var isPickup = true
    @State private var showBookingAlert = false
    @StateObject private var keyboard = KeyboardResponder()
    @EnvironmentObject private var router: NavigationRouter

    let tabs = [("home", "Home"), ("chat", "Chat"), ("history", "History"), ("profile", "Profile")]

    var body: some View {
        ZStack(alignment: .top) {
            CustomMapView (
                region: $viewModel.region,
                annotations: makeAnnotations(),
                routes: viewModel.route.map { [$0] } ?? []
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 18) {
                VStack(spacing: 12) {
                    addressPicker(
                        isPickup: true,
                        label: "Pickup Address",
                        text: $viewModel.pickupAddress
                    )
                    .onTapGesture {
                        isPickup = true
                        showSuggestions = true
                    }

                    addressPicker(
                        isPickup: false,
                        label: "Drop Address",
                        text: $viewModel.dropoffAddress
                    )
                    .onTapGesture {
                        isPickup = false
                        showSuggestions = true
                    }

                    Button {
                        guard let pickupCoordinate = viewModel.pickupCoordinate,
                              let dropoffCoordinate = viewModel.dropoffCoordinate,
                              !viewModel.pickupAddress.isEmpty,
                              !viewModel.dropoffAddress.isEmpty,
                              !pickupCoordinate.latitude.isNaN && !pickupCoordinate.longitude.isNaN,
                              !dropoffCoordinate.latitude.isNaN && !dropoffCoordinate.longitude.isNaN
                        else {
                            showBookingAlert = true
                            return
                        }

                        let bookingData = BookingDetailData(
                            pickup: LocationDetail(address: viewModel.pickupAddress,
                                                   latitude: pickupCoordinate.latitude,
                                                   longitude: pickupCoordinate.longitude),
                            dropoff: LocationDetail(address: viewModel.dropoffAddress,
                                                    latitude: dropoffCoordinate.latitude,
                                                    longitude: dropoffCoordinate.longitude)
                        )

                        router.push(to: .bookingDetails(bookingData))
                    } label: {
                        Text("Book Trip")
                            .font(.customfont(.bold, fontSize: 18))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(.colorNeavyBlue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                    }
                    .alert("Address Required", isPresented: $showBookingAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Please select both Pickup and Drop-off addresses before booking.")
                    }

                    if showSuggestions {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.searchResults.prefix(7), id: \.self) { item in
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.title)
                                            .font(.headline)
                                        if !item.subtitle.isEmpty {
                                            Text(item.subtitle)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white)
                                    .onTapGesture {
                                        viewModel.selectCompletion(item, isPickup: isPickup)
                                        showSuggestions = false
                                    }
                                    Divider()
                                }
                            }
                        }
                        .frame(minHeight: 20, maxHeight: 210)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                        .shadow(radius: 4)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .cornerRadius(22)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 5)
                .padding(.horizontal, 18)

                Spacer()

                if !keyboard.keyboardShown {
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
                            .onTapGesture {
                                selectedTab = index
                                switch index {
                                case 0: router.push(to: .home)
                                case 1: router.push(to: .chat)
                                case 2: router.push(to: .history)
                                case 3: router.push(to: .settings)
                                default: break
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 12)
                    .background(Color.colorNeavyBlue)
                    .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
                }
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                showSuggestions = false
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CustomLogo()
                        .frame(width: 100, height: 120)
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
            selectedTab = 0
        }
        .animation(.easeOut, value: showSuggestions)
        .animation(.easeOut, value: keyboard.keyboardShown)
    }

    func addressPicker(isPickup: Bool, label: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: isPickup ? "mappin.and.ellipse" : "flag")
                .foregroundColor(.blue)
            TextField(label, text: text)
                .onChange(of: text.wrappedValue, perform: { value in
                    viewModel.searchText = value
                })
            Spacer()
            if !text.wrappedValue.isEmpty {
                Button {
                    text.wrappedValue = ""
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }

    func makeAnnotations() -> [MKPointAnnotation] {
        var result: [MKPointAnnotation] = []
        if let pickup = viewModel.pickupCoordinate,
           !pickup.latitude.isNaN && !pickup.longitude.isNaN {
            let ann = MKPointAnnotation()
            ann.coordinate = pickup
            ann.title = "Pickup"
            result.append(ann)
        }
        if let drop = viewModel.dropoffCoordinate,
           !drop.latitude.isNaN && !drop.longitude.isNaN {
            let ann = MKPointAnnotation()
            ann.coordinate = drop
            ann.title = "Drop-off"
            result.append(ann)
        }
        return result
    }
}

#Preview {
    HomeView()
}
