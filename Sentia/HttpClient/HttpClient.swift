//
//  HttpClient.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation
import Combine

class DataManagerList {
    private let urlString = "https://f213b61d-6411-4018-a178-53863ed9f8ec.mock.pstmn.io/properties"
    var usersPublisher: AnyPublisher<ListModel, Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ListModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }

enum DataError:Error {
    case noDataAvailable
    case imageLoadFailed
}
enum ValidationError: LocalizedError {
    case invalidValue
}
