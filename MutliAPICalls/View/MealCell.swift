//
//  MealCell.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class MealCell: UITableViewCell {

    static let identifier = "MealCell"
    
    let mealImageView = UIImageView()
    let nameLabel = UILabel()
    let categoryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        mealImageView.contentMode = .scaleAspectFill
        mealImageView.clipsToBounds = true
        mealImageView.layer.cornerRadius = 60
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.textColor = .gray
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 2
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerStackView = UIStackView(arrangedSubviews: [mealImageView, labelStackView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
     
        contentView.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            
            mealImageView.widthAnchor.constraint(equalToConstant: 120),
            mealImageView.heightAnchor.constraint(equalToConstant: 120),

            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with meal: Meal) {
        nameLabel.text = meal.strMeal
        categoryLabel.text = "Category: \(meal.strCategory)"
        if let url = URL(string: meal.strMealThumb) {
            Task {
                if let image = try? await NetworkManager.shared.fetchImage(from: url.absoluteString) {
                    DispatchQueue.main.async {
                        self.mealImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.mealImageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            mealImageView.image = UIImage(named: "placeholder")
        }
    }
}
