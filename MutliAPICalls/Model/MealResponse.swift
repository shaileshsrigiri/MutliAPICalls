//
//  MealResponse.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
   
}