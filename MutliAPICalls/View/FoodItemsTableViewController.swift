//
//  FoodItemsTableViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import UIKit

class FoodItemsTableViewController: UITableViewController {
    
    var foodItems: [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: FoodItemCell.identifier)
        tableView.separatorStyle = .none
    }
    
}

extension FoodItemsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodItemCell.identifier, for: indexPath) as! FoodItemCell
        let foodItem = foodItems[indexPath.row]
        cell.configure(with: foodItem)
        return cell
    }

}
    

