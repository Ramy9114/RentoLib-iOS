//
//  UserModel.swift
//  RentoLib
//
//  Created by Rami Moubayed on 22/02/2021.
//

import Foundation

struct UserModel{
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
    var userLocation: UserLocationModel?
}

struct UserLocationModel{
    var userLocationId: Int
    var userId: Int
    var zipCode: Int
    var address: String
    var complementAddress: String
    var addressTwo: String
    var complementAddressTwo: String
    var cityId: Int
    var city: CityModel?
    
}

struct CityModel{
    var cityId: Int
    var name: String
    var country: CountryModel?
    
}

struct CountryModel{
    var countryId: Int
    var name: String
    

}

struct UserAuthentication: Codable {
    let username: String
    let password: String
}
