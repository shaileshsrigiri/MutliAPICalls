//
//  CountriesTableViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class CountriesTableViewController: UITableViewController, UISearchResultsUpdating {

    let viewModel = CountriesViewModel()
    let urlString = APIEndpoints.countriesURL
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupSearchController()
        fetchCountries()
    }

    func setupTableView() {
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.filterCountries(by: searchText)
    }

    func fetchCountries() {
        viewModel.fetchCountries(from: urlString)
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


extension CountriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountryCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as! CountryTableViewCell
        if let country = viewModel.getCountry(at: indexPath.row) {
            cell.configure(with: country)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCountry = viewModel.getCountry(at: indexPath.row) {
            navigateToCountryDetail(for: selectedCountry)
        }
    }

    func navigateToCountryDetail(for country: Country) {
        let detailVC = CountryDetailViewController()
        detailVC.configure(with: country)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
