//
//  CountriesViewModel.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


import UIKit

class CountriesViewModel {

    var countries: [Country] = []
    var filteredCountries: [Country] = []
    var onDataFetched: (() -> Void)?

    func fetchCountries(from url: String) {
        Task {
            do {
                self.countries = try await NetworkManager.shared.fetchData(from: url, decodingType: [Country].self)
                self.filteredCountries = self.countries
                DispatchQueue.main.async { [weak self] in
                    self?.onDataFetched?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching countries: \(error)")
                }
            }
        }
    }
    
    func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        }
        onDataFetched?()
    }

    func getCountryCount() -> Int {
        return filteredCountries.count
    }

    func getCountry(at index: Int) -> Country? {
        guard index >= 0 && index < filteredCountries.count else { return nil }
        return filteredCountries[index]
    }
}
