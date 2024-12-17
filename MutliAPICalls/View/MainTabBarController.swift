//
//  MainTabBarController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        let PhotosVC = PhotosViewController()
        let FoodGroupsTableVC = FoodGroupsTableViewController()
        let mealsTableVC = MealsTableViewController()
        let CountriesTableVC = CountriesTableViewController()

        let firstNavVC = UINavigationController(rootViewController: PhotosVC)
        let secondNavVC = UINavigationController(rootViewController: FoodGroupsTableVC)
        let thirdNavVC = UINavigationController(rootViewController: mealsTableVC)
        let fourthNavVC = UINavigationController(rootViewController: CountriesTableVC)

        firstNavVC.tabBarItem = UITabBarItem(title: "Photos", image: UIImage(systemName: "1.fill.circle"), tag: 0)
        secondNavVC.tabBarItem = UITabBarItem(title: "Food", image: UIImage(systemName: "2.fill.circle"), tag: 1)
        thirdNavVC.tabBarItem = UITabBarItem(title: "Meals", image: UIImage(systemName: "3.fill.circle"), tag: 2)
        fourthNavVC.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "4.fill.circle"), tag: 3)

        viewControllers = [firstNavVC, secondNavVC, thirdNavVC, fourthNavVC]
    }
}
