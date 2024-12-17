//
//  NetworkManaging.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation
import UIKit

protocol NetworkManaging {
    func fetchData<T: Decodable>(from urlString: String, decodingType: T.Type) async throws -> T
    func fetchImage(from urlString: String) async throws -> UIImage
}
