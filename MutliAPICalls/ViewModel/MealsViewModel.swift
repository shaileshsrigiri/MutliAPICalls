//
//  MealsViewModel.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


import UIKit

class MealsViewModel {

    var meals: [Meal] = []
    var onDataFetched: (() -> Void)?

    func fetchMeals(from url: String) {
        Task {
            do {
                let response: MealResponse = try await NetworkManager.shared.fetchData(from: url, decodingType: MealResponse.self)
                DispatchQueue.main.async { [weak self] in
                    self?.meals = response.meals
                    self?.onDataFetched?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching meals: \(error)")
                }
            }
        }
    }

    func getMealCount() -> Int {
        return meals.count
    }

    func getMeal(at index: Int) -> Meal {
        meals[index]
    }
}
