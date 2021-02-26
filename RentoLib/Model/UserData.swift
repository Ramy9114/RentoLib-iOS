//
//  UserData.swift
//  RentoLib
//
//  Created by Rami Moubayed on 22/02/2021.
//

import Foundation

struct User: Codable{
    var userId: Int
    var firstName: String
    var middleName: String
    var lastName: String
    var age: Int
    var telephone: String
    var username: String
    var email: String
    var password: String
    var picture: String
    var userLocation: UserLocation?
}

struct UserLocation: Codable{
    var userLocationId: Int
    var userId: Int
    var zipCode: Int
    var address: String
    var complementAddress: String
    var addressTwo: String
    var complementAddressTwo: String
    var cityId: Int
    var city: City?
    
}

struct City: Codable{
    var cityId: Int
    var name: String
    var country: Country?
    
}

struct Country: Codable{
    var countryId: Int
    var name: String
    

}
