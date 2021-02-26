//
//  ProductData.swift
//  RentoLib
//
//  Created by Rami Moubayed on 25/02/2021.
//

import Foundation

struct Product: Codable {
    var productId: Int
    var userId: Int
    var productSubcategoryId: Int
    var name: String
    var description: String
    var pricePerDay: Float
    var status: Bool
}

struct ProductSubcategory: Codable {
    var productSubcategoryId: Int
    var name: String
}

struct ProductCategory: Codable {
    var productCategoryId: Int
    var name: String
    var productSubcategories : [ProductSubcategory]
}
