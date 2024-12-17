//
//  CountryTableViewCell.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    static let identifier = "CountryTableViewCell"

    let flagImageView = UIImageView()
    let nameLabel = UILabel()
    let regionLabel = UILabel()
        

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = 8
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
            
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        regionLabel.font = UIFont.systemFont(ofSize: 14)
        regionLabel.textColor = .gray
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, regionLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageStack = UIStackView(arrangedSubviews: [flagImageView, stackView])
        imageStack.axis = .horizontal
        imageStack.spacing = 10
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageStack)

        NSLayoutConstraint.activate([
            
            flagImageView.widthAnchor.constraint(equalToConstant: 100),
            flagImageView.heightAnchor.constraint(equalToConstant: 100),

            imageStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with country: Country) {
        nameLabel.text = country.name
        regionLabel.text = country.region
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
