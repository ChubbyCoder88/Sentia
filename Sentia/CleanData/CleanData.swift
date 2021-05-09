//
//  CleanData.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation
import UIKit
struct CleanData {
    
    func refactorAndInsertIntoViewModel(data: ListModel, completion: @escaping(Result<[ListViewModel], DataError>) -> Void) throws {
       var listData = [ListViewModel]()
        if let tra = data.data {
           for a in tra {
            
            var id = ""
            if let idA = a.id {
                id = idA
            }
            var bedrooms = ""
            if let bedroomsA = a.bedrooms {
                let string = String(bedroomsA)
                bedrooms = string
            }
            var bathrooms = ""
            if let bathroomsA = a.bathrooms {
                let string = String(bathroomsA)
                bathrooms = string
            }
            var carspaces = ""
            if let carspacesA = a.carspaces {
                let string = String(carspacesA)
                carspaces = string
            }
            var address = ""
            if let addressA = a.location?.address {
                if addressA.contains(",") {
                    let replaced = addressA.replacingOccurrences(of: ", ", with: "\n")
                    address = replaced
                }
            }
            var propertyImage = ""
            if let propertyImageA = a.property_images?.first?.attachment?.url {
                propertyImage = propertyImageA
            }
            var agentFirstName = ""
            if let agentFirstNameA = a.agent?.first_name {
                agentFirstName = agentFirstNameA
            }
            var agentLastName = ""
            if let agentLastNameA = a.agent?.last_name {
                agentLastName = agentLastNameA
            }
            var agentName = agentFirstName + " " + agentLastName
            
            var agentCompanyName = ""
            if let agentCompanyNameA = a.agent?.company_name {
                agentCompanyName = agentCompanyNameA
            }
            var agentImageSmall = ""
            if let agentImageSmallA = a.agent?.avatar?.small?.url {
                agentImageSmall = agentImageSmallA
            }
            var input = ListViewModel(id: id, bedrooms: bedrooms, bathrooms: bathrooms, carspaces: carspaces, address: address, propertyImage: propertyImage, agentName: agentName, agentCompanyName: agentCompanyName, agentImageSmall: agentImageSmall)
            listData.append(input)
           }
       } else { throw DataError.noDataAvailable }
        if listData.count < 1 { throw DataError.noDataAvailable }
        completion(.success(listData))
        listData = []
   }
}
