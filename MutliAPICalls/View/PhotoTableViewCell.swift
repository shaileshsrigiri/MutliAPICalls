//
//  PhotoTableViewCell.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "PhotoTableViewCell"
    var currentImageUrl: String?

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        currentImageUrl = photo.thumbnailUrl
        thumbnailImageView.image = nil

        Task {
            if let image = try? await NetworkManager.shared.fetchImage(from: photo.thumbnailUrl) {
                if self.currentImageUrl == photo.thumbnailUrl {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if self.currentImageUrl == photo.thumbnailUrl {
                        self.thumbnailImageView.image = UIImage(systemName: "exclamationmark.circle")
                    }
                }
            }
        }
    }
}


