//
//  ViewModel.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation

// List
struct ListViewModel:Decodable, Equatable {
    var id: String
    let bedrooms: String?
    let bathrooms: String?
    let carspaces: String?
    let address: String?
    let propertyImage: String?
    let agentName: String?
    let agentCompanyName: String?
    let agentImageSmall: String?
}
