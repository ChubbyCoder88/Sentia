//
//  Model.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation

// List
struct ListModel:Decodable {
    var data: [List]?
}
struct List:Decodable {
    let id: String?
    let bedrooms: Int?
    let bathrooms: Int?
    let carspaces: Int?
    let display_price: String?
    let currency: String?
    let location: Location?
    let property_images: [PropertyImages]?
    let agent: Agent?
}
struct Location:Decodable {
    let address: String?
    let state: String?
    let suburb: String?
}
struct PropertyImages:Decodable {
    let attachment: URLPropertyImage?
}
struct URLPropertyImage:Decodable {
    let url: String?
}
struct Agent:Decodable {
    let first_name: String?
    let last_name: String?
    let company_name: String?
    let avatar: URLAgentAvatarImage?
}
struct URLAgentAvatarImage:Decodable {
    let small: smallImage?
}
struct smallImage:Decodable {
    let url: String?
}
