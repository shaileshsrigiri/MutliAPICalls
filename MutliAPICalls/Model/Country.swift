//
//  Country.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/12/24.
//


struct Country: Codable {
    let name: String
    let capital: String?
    let code: String
    let region: String
    let flag: String
    let currency: Currency
    let language: Language
}

struct Currency: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

struct Language: Codable {
    let code: String?
    let name: String? 
}