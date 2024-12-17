//
//  PhotoDetailViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            imageView.heightAnchor.constraint(equalToConstant: 600),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
        ])
    }

    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        descriptionLabel.text = "Photo ID: \(photo.id)"
        if let url = URL(string: photo.url) {
            Task {
                if let image = try? await NetworkManager.shared.fetchImage(from: url.absoluteString) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
