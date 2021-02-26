//
//  SearchFilterData.swift
//  RentoLib
//
//  Created by Rami Moubayed on 25/02/2021.
//

import Foundation

struct ProductFilter: Codable {
    var productSubcategoryId: Int?
    var productCategoryId: Int?
    var name: String?
    var priceFrom: Float?
    var priceTo: Float?
    var status: Bool?
    
}
