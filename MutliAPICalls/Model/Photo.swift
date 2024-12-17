//
//  Photo.swift
//  MutliAPICalls
//
//  Created by Shailesh Srigiri on 12/11/24.
//


import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}