//
//  PhotosViewModel.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation
import UIKit

class PhotosViewModel {
    var photos: [Photo] = []
    var onDataFetched: (() -> Void)?

    func fetchPhotos() {
        Task {
            do {
                self.photos = try await NetworkManager.shared.fetchData(from: APIEndpoints.photosURL, decodingType: [Photo].self)
                DispatchQueue.main.async {
                    self.onDataFetched?()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching photos data: \(error)")
                }
            }
        }
    }

    func photo(at index: Int) -> Photo {
        photos[index]
    }

    var numberOfPhotos: Int {
        return photos.count
    }
}


