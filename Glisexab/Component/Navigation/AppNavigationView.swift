//
//  AppNavigationView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/10/25.
//

import SwiftUI

enum AppNavigationView: Hashable {
    
    case onboarding
    case login
    case signup
    case forgetPassword
    case home
    case bookingDetails
    case scheduleBooking
    case trackDriver
    case rideDetails
    case driverDetails
    case history
    case settings
    case editProfile
    case addAddress
    case saveAddress
    
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
        case .bookingDetails:
            BookingView()
        case .scheduleBooking:
            ScheduleBookingView()
        case .trackDriver:
            TrackingView()
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
        }
    }
}
