//
//  FoodGroupCell.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//

import Foundation
import UIKit

class FoodGroupCell: UITableViewCell {

    static let identifier = "FoodGroupCell"

    let groupImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        groupImageView.contentMode = .scaleAspectFit
        groupImageView.clipsToBounds = true
        groupImageView.layer.cornerRadius = 8
        groupImageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
          
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let imageStack = UIStackView(arrangedSubviews: [groupImageView, nameLabel, descriptionLabel])
        imageStack.axis = .vertical
        imageStack.spacing = 10
        imageStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageStack)

        NSLayoutConstraint.activate([

            groupImageView.widthAnchor.constraint(equalToConstant: 200),
            groupImageView.heightAnchor.constraint(equalToConstant: 200),

            imageStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with foodGroup: FoodGroup) {
        nameLabel.text = foodGroup.name
        descriptionLabel.text = foodGroup.description

        if let imageUrl = foodGroup.image_url, let url = URL(string: imageUrl) {
            Task {
                if let image = try? await NetworkManager.shared.fetchImage(from: url.absoluteString) {
                    DispatchQueue.main.async {
                        self.groupImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.groupImageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            groupImageView.image = UIImage(named: "placeholder")
        }
    }
}
