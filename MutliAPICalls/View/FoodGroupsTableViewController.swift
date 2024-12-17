//
//  FoodGroupsTableViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import UIKit

class FoodGroupsTableViewController: UITableViewController {
    
    let urlString = APIEndpoints.foodDataURL
    var foodGroupsViewModel = FoodGroupsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        fetchFoodGroups()
    }

    func setupTableView() {
        tableView.register(FoodGroupCell.self, forCellReuseIdentifier: "FoodGroupCell")
    }

    func fetchFoodGroups() {
        foodGroupsViewModel.fetchFoodGroups()
        foodGroupsViewModel.onDataFetched = { [weak self] in
            self?.reloadTableView()
        }
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FoodGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodGroupsViewModel.getFoodCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodGroupCell", for: indexPath) as! FoodGroupCell
        let foodGroup = foodGroupsViewModel.getFoodForGroup(index: indexPath.row)
        cell.configure(with: foodGroup)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFoodGroup = foodGroupsViewModel.getFoodForGroup(index: indexPath.row)
        navigateToFoodItems(for: selectedFoodGroup)
    }

    func navigateToFoodItems(for foodGroup: FoodGroup) {
        let foodItemsVC = FoodItemsTableViewController()
        foodItemsVC.foodItems = foodGroup.food_items ?? []
        foodItemsVC.title = foodGroup.name
        navigationController?.pushViewController(foodItemsVC, animated: true)
    }
}
