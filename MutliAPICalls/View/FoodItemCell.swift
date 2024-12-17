//
//  FoodItemCell.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//

import UIKit

class FoodItemCell: UITableViewCell {

    static let identifier = "FoodItemCell"

    let itemImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 8
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
         
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .blue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        let labelStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 2
        //labelStack.distribution = .fillProportionally
        labelStack.translatesAutoresizingMaskIntoConstraints = false
    
        let imageStack = UIStackView(arrangedSubviews: [itemImageView, labelStack])
        imageStack.axis = .horizontal
        imageStack.spacing = 10
        //imageStack.distribution = .fillProportionally
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        containerView.translatesAutoresizingMaskIntoConstraints = false
       
        containerView.addSubview(imageStack)
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            imageStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imageStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configure(with foodItem: FoodItem) {
        nameLabel.text = foodItem.name
        descriptionLabel.text = foodItem.description
        priceLabel.text = foodItem.price != nil ? "$\(foodItem.price!)" : "Price not available"

        if let imageUrl = foodItem.image_url, let url = URL(string: imageUrl) {
            Task {
                if let image = try? await NetworkManager.shared.fetchImage(from: url.absoluteString) {
                    DispatchQueue.main.async {
                        self.itemImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.itemImageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            itemImageView.image = UIImage(named: "placeholder")
        }
    }
}
