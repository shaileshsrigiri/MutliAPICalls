//
//  NetworkManager.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation
import UIKit

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        self.session = URLSession(configuration: .default)
    }

    func fetchData<T: Decodable>(from urlString: String, decodingType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    
    func fetchImage(from urlString: String) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            return cachedImage
        }

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await session.data(from: url)

        guard let image = UIImage(data: data) else {
            throw NetworkError.imageFetchFailed
        }

        cache.setObject(image, forKey: NSString(string: urlString))
        return image
    }
}
