//
//  PhotosViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import UIKit

class PhotosViewController: UIViewController {

    let tableView = UITableView()
    var viewModel = PhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        bindViewModel()
        viewModel.fetchPhotos()
    }

    func setupUI() {
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func bindViewModel() {
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        let photo = viewModel.photo(at: indexPath.row)
        cell.configure(with: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModel.photo(at: indexPath.row)
        let detailVC = PhotoDetailViewController()
        detailVC.configure(with: photo)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
