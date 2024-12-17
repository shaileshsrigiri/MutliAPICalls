//
//  FoodGroupsViewModel.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation

class FoodGroupsViewModel {

    var foodGroups: [FoodGroup] = []
    var onDataFetched: (() -> Void)?

    func fetchFoodGroups() {
        Task {
            do {
                let response: FoodGroupsResponse = try await NetworkManager.shared.fetchData(from: APIEndpoints.foodDataURL, decodingType: FoodGroupsResponse.self)
                DispatchQueue.main.async { [weak self] in
                    self?.foodGroups = response.food_groups ?? []
                    self?.onDataFetched?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching food groups: \(error)")
                }
            }
        }
    }

    func getFoodCount() -> Int {
        return foodGroups.count
    }

    func getFoodForGroup(index: Int) -> FoodGroup {
        foodGroups[index]
    }
}
