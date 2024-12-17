//
//  MealsTableViewController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//

import UIKit

class MealsTableViewController: UITableViewController {
    
    let viewModel = MealsViewModel()
    let urlString = APIEndpoints.mealsURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meals"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        fetchMeals()
    }
    
    func setupTableView() {
        tableView.register(MealCell.self, forCellReuseIdentifier: MealCell.identifier)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func fetchMeals() {
        viewModel.fetchMeals(from: urlString)
        viewModel.onDataFetched = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MealsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMealCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.identifier, for: indexPath) as! MealCell
        let meal = viewModel.getMeal(at: indexPath.row)
        cell.configure(with: meal)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = viewModel.getMeal(at: indexPath.row)
        navigateToMealDetail(for: selectedMeal)
        
    }

    func navigateToMealDetail(for meal: Meal) {
        let detailVC = MealDetailViewController()
        detailVC.configure(with: meal)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
    


