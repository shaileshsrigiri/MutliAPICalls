//
//  CountryDetailViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class CountryDetailViewController: UIViewController {

    let nameLabel = UILabel()
    let capitalLabel = UILabel()
    let currencyLabel = UILabel()
    let languageLabel = UILabel()
    let flagImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.clipsToBounds = true
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        capitalLabel.font = .systemFont(ofSize: 18)
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currencyLabel.font = .systemFont(ofSize: 18)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        languageLabel.font = .systemFont(ofSize: 18)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [flagImageView, nameLabel, capitalLabel, currencyLabel, languageLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            flagImageView.heightAnchor.constraint(equalToConstant: 400),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
    }

    func configure(with country: Country) {
        nameLabel.text = "Name: \(country.name)"
        capitalLabel.text = "Capital: \(country.capital ?? "N/A")"
        currencyLabel.text = "Currency: \(country.currency.name ?? "N/A") (\(country.currency.symbol ?? ""))"
        languageLabel.text = "Language: \(country.language.name ?? "N/A")"
        if let url = URL(string: country.flag) {
            Task {
                if let image = try? await NetworkManager.shared.fetchImage(from: url.absoluteString) {
                    DispatchQueue.main.async {
                        self.flagImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.flagImageView.image = UIImage(systemName: "globe")
                    }
                }
            }
        } else {
            flagImageView.image = UIImage(systemName: "globe")
        }
    }
}
