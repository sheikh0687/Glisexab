//
//  SearchCompleterViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/10/25.
//

internal import Combine
import MapKit

class SearchCompleterViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var queryFragment = ""
    @Published var results: [MKLocalSearchCompletion] = []
    private var completer: MKLocalSearchCompleter
    private var cancellable: AnyCancellable?
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init() // 👈 MUST call super.init() BEFORE using 'self'
        completer.resultTypes = .address
        completer.delegate = self
        cancellable = $queryFragment
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] fragment in
                self?.completer.queryFragment = fragment
            }
    }

    // MARK: - MKLocalSearchCompleterDelegate
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle error if needed
    }
}
