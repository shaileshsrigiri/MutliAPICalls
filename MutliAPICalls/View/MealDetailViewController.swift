//
//  MealDetailViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class MealDetailViewController: UIViewController {

    let nameLabel = UILabel()
    let categoryLabel = UILabel()
    let areaLabel = UILabel()
    let instructionsLabel = UILabel()
    let mealImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        mealImageView.contentMode = .scaleAspectFill
        mealImageView.clipsToBounds = true
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.font = .systemFont(ofSize: 18)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        areaLabel.font = .systemFont(ofSize: 18)
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        instructionsLabel.font = .systemFont(ofSize: 16)
        instructionsLabel.numberOfLines = 0
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [mealImageView,nameLabel, categoryLabel, areaLabel, instructionsLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            mealImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configure(with meal: Meal) {
        nameLabel.text = "Name: \(meal.strMeal)"
        categoryLabel.text = "Category: \(meal.strCategory)"
        areaLabel.text = "Area: \(meal.strArea)"
        instructionsLabel.text = "Instructions: \(meal.strInstructions)"
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
