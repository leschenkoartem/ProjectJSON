//
//  InfoModel.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 30.03.2023.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
