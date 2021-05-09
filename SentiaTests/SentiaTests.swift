//
//  SentiaTests.swift
//  SentiaTests
//
//  Created by Matthew on 7/5/21.
//

import XCTest
import Combine
@testable import Sentia

class SentiaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testThatEmptyDataWillThrow() throws {
        let clean = CleanData()
        let model = ListModel()
        XCTAssertThrowsError(try clean.refactorAndInsertIntoViewModel(data: model, completion: { (data) in
        })) {
            thrownError in
        }
    }

    func testCorrectApiDataWillNotThrow() throws {
        let clean = CleanData()
        var listData = [ListViewModel]()
        let model = ListModel(data: [List(id: "1", bedrooms: 6, bathrooms: 3, carspaces: 2, display_price: "$2,430,000", currency: "AUD", location: (Sentia.Location(address: "10/178 Campbell Parade, Bondi Beach NSW 2026", state: "NSW", suburb: "Bondi Beach")), property_images: [Sentia.PropertyImages(attachment: Sentia.URLPropertyImage(url: "https://cdn.pixabay.com/photo/2016/11/18/17/46/architecture-1836070__340.jpg")), Sentia.PropertyImages(attachment: Sentia.URLPropertyImage(url: "https://cdn.pixabay.com/photo/2016/11/29/03/53/architecture-1867187__340.jpg"))], agent: Sentia.Agent(first_name: "Earl", last_name: "Thomas", company_name: "Sydney Real Estate", avatar: Sentia.URLAgentAvatarImage(small: Sentia.smallImage(url: "https://images.pexels.com/photos/3556533/pexels-photo-3556533.jpeg"))))])
                                              
        XCTAssertNoThrow(try clean.refactorAndInsertIntoViewModel(data: model, completion: { (result) in
            switch result {
            case .failure(let error): print("error", error)
            case .success(let data1): listData = data1
            }
        }))
        
        // Test that the address is being edited & being edited correctly
        if listData.count > 0 {
            var firstResult = listData[0]
            var addressUnedited = "10/178 Campbell Parade, Bondi Beach NSW 2026"
            var addressEdited = firstResult.address
            var addressPerfect = "10/178 Campbell Parade\nBondi Beach NSW 2026"
            if let addressEdited = addressEdited {
                XCTAssertNotEqual(addressUnedited, addressEdited)
                XCTAssertEqual(addressEdited, addressPerfect)
            }
        }
        
        // test that the agentName is being combined correctly
        var agentFirstName = "Earl"
        var agentLastName = "Thomas"
        var agentNameCombined = agentFirstName + " " + agentLastName
        if listData.count > 0 {
            var firstResult = listData[0]
            var agentNameEdited = firstResult.agentName
            XCTAssertEqual(agentNameCombined, agentNameEdited)
        }
    }
    
}
