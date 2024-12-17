//
//  MainTabBarController.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


import UIKit

class MainTabBarController: UITabBarController {

    private let endpoints = [
        (APIEndpoints.photosURL, "Photos"),
        (APIEndpoints.foodDataURL, "Food"),
        (APIEndpoints.mealsURL, "Meals"),
        (APIEndpoints.countriesURL, "Countries")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        validateAPIsSequentiallyAndSetupTabs()
    }

    func validateAPIsSequentiallyAndSetupTabs() {
        Task {
            var validatedTabs: [UIViewController] = []

            for (index, (url, title)) in endpoints.enumerated() {
                do {
                    _ = try await NetworkManager.shared.fetchData(from: url, decodingType: DummyResponse.self)
                    let viewController = getViewController(for: index)
                    let navVC = UINavigationController(rootViewController: viewController)
                    navVC.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "\(index + 1).circle"), tag: index)
                    validatedTabs.append(navVC)
                } catch {
                    showErrorAlert(for: title, error: error)
                    break
                }
            }

            DispatchQueue.main.async {
                self.viewControllers = validatedTabs
            }
        }
    }

    private func getViewController(for index: Int) -> UIViewController {
        switch index {
        case 0: return PhotosViewController()
        case 1: return FoodGroupsTableViewController()
        case 2: return MealsTableViewController()
        case 3: return CountriesTableViewController()
        default: return UIViewController()
        }
    }

    private func showErrorAlert(for tabName: String, error: Error) {
        let alert = UIAlertController(
            title: "API Error",
            message: "Failed to load data for \(tabName) tab. Error: \(error.localizedDescription)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

struct DummyResponse: Codable {}
