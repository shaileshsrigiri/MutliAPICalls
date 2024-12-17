//
//  FoodGroupsResponse.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation

struct FoodGroupsResponse: Codable {
    let food_groups: [FoodGroup]?
}

struct FoodGroup: Codable {
    let id: Int
    let name: String
    let description: String?
    let image_url: String?
    let food_items: [FoodItem]?
}

struct FoodItem: Codable {
    let id: Int
    let name: String
    let description: String?
    let weight: Int?
    let price: Int?
    let image_url: String?
}