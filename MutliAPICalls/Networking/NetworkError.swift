//
//  NetworkError.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case imageFetchFailed
}
