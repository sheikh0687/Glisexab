//
//  AppNavigationView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/10/25.
//

import SwiftUI
import MapKit

enum AppNavigationView: Hashable {
    
    case onboarding
    case login
    case signup
    case forgetPassword
    case home
    case bookingDetails(BookingDetailData)
    case scheduleBooking(ScheduleBookingViewModel)
    case trackDriver(LocationSearchViewModel)
    case rideDetails
    case driverDetails
    case history
    case settings
    case editProfile
    case addAddress
    case saveAddress
    case chat
    case changePassword
    case searchDriver(LocationSearchViewModel)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .login:
            LoginView()
        case .signup:
            SignupView()
        case .forgetPassword:
            ForgetPasswordView()
        case .onboarding:
            OnboardingView()
        case .home:
            HomeView()
        case .settings:
            SettingView()
        case .bookingDetails(let data):
            BookingView(viewModel: BookingDetailViewModel(data: data))
        case .scheduleBooking(let viewModel):
            ScheduleBookingView(viewModel: viewModel)
        case .trackDriver(let viewModel):
            TrackingView(locationManager: viewModel)
        case .rideDetails:
            RideDetailView()
        case .driverDetails:
            DriverDetailView()
        case .editProfile:
            EditProfileView()
        case .addAddress:
            AddAddressView()
        case .saveAddress:
            SaveAddressView()
        case .history:
            HistoryView()
        case .chat:
            ChatView()
        case .changePassword:
            ChangePasswordView()
        case .searchDriver(let viewModel):
            SearchDriverView(viewModel: viewModel)
        }
    }
}
