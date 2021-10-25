//
//  OCSTests.swift
//  OCSTests
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import XCTest
@testable import OCS

class OCSTests: XCTestCase {
    let homeViewMode = HomeViewModel()
    let videViewMode = VideoViewModel()

    func testGetProgramme() {
        let expectation = XCTestExpectation(description: "Download some data")

        homeViewMode.getProgrammeResponseModel(programmeTitle: "", completionHandler: {
            res in
            XCTAssertNil(res, "No data was downloaded.")
            expectation.fulfill()

        })
        
        homeViewMode.getProgrammeResponseModel(programmeTitle: "dsadas", completionHandler: {
            res in
            XCTAssertNotNil(res, "data was downloaded.")
            expectation.fulfill()


        })

        wait(for: [expectation], timeout: 10.0)


    }
    
    func testGetDetailsSerie() {
        let expectation = XCTestExpectation(description: "Download some data")

        videViewMode.getDetailsSerieResponseModel(urlPrg: "String", completionHandler: {
            res,error  in
            XCTAssertNil(res, "No data was downloaded.")
            expectation.fulfill()

        })
        
        videViewMode.getDetailsSerieResponseModel(urlPrg: "https://api.ocs.fr/apps/v2/details/serie/PSGAMEOFTHRW0058624", completionHandler: {
            res,error  in
            XCTAssertNotNil(res, "data was downloaded.")
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: 10.0)

    }
    

}
