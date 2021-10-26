//
//  OCSTests.swift
//  OCSTests
//
//  Created by Nizar Elhraiech on 23/10/2021.
//

import XCTest
import Combine
@testable import OCS

class OCSTests: XCTestCase {
    let homeService = HomeService()
    let videoService = VideoService()
    let homeVm = HomeViewModel()
    let videoVm = VideoViewModel()
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testUrlIsNil() {
        let result = homeVm.encodeUrl(title: "")
        XCTAssertNotNil(result, "Not nil")
    }
    
    func testUrl() {
        let result = homeVm.encodeUrl(title: "game of thrones")
        guard let res = result else {
            return
        }
        XCTAssertEqual(res.absoluteString, "https://api.ocs.fr/apps/v2/contents?search=title%3Dgame%20of%20thrones", res.absoluteString)
        
    }
    
    func testGetProgramme() {
        let result = homeVm.encodeUrl(title: "game of thrones")
        guard let res = result else {
            return
        }
        
        let expectation = XCTestExpectation(description: "Download some data")
        homeService.getProgrmmes(urlDetail: res)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    break
                }
                expectation.fulfill()
            }, receiveValue: { value in
                XCTAssertNotNil(res, "data was downloaded.")
                
            })
            .store(in: &cancellables)
        
    }
    
    func testGetDetailsSerie() {
        let expectation = XCTestExpectation(description: "Download some data")
        let result = videoVm.encodeUrl(urlDetail: "https://api.ocs.fr/apps/v2/details/serie/PSGAMEOFTHRW0058624")
        guard let res = result else {
            return
        }
        videoService.fetch(urlDetail: res).sink(receiveCompletion: {
            completion in
            switch completion {
            case .finished:
                break
            case .failure(let encounteredError):
                break
            }
            expectation.fulfill()
            
        }, receiveValue: {
            res in
            XCTAssertNotNil(res, "data was downloaded.")
            
        }).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
}
