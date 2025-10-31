//
//  CountryPickerUI.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import SwiftUI
import CountryPicker

struct CountryPickerUI: UIViewControllerRepresentable {
    typealias UIViewControllerType = CountryPickerViewController

    let countryPicker = CountryPickerViewController()

    @Binding var country: Country?

    func makeUIViewController(context: Context) -> CountryPickerViewController {
        countryPicker.selectedCountry = "TR"
        countryPicker.delegate = context.coordinator
        return countryPicker
    }

    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
        //
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CountryPickerDelegate {
        var parent: CountryPickerUI
        init(_ parent: CountryPickerUI) {
            self.parent = parent
        }
        func countryPicker(didSelect country: Country) {
            parent.country = country
        }
    }
}
