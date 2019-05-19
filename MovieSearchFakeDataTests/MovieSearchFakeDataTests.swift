//
//  MovieSearchFakeDataTests.swift
//  MovieSearchFakeDataTests
//
//  Created by Tom Murray on 19/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieSearchFakeDataTests: XCTestCase {

	var apiUnderTest: HttpAPI!
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		apiUnderTest = HttpAPI()
		
		
    }

	func testMockRequest() {
		let testBundle = Bundle(for: type(of: self))
		let path = testBundle.path(forResource: "MockData", ofType: "json")
		let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
		
		let url = URL(dataRepresentation: data!, relativeTo: URL(fileURLWithPath: path!))
		
		let promise = expectation(description: "Status code: 200")
		
		apiUnderTest.makeRequest(url: URLRequest(url: url!), for: MovieDeatils.self) { (success, result) -> (Void) in
			if success {
				promise.fulfill()
			} else {
				XCTFail("Failed to parse data")
			}
		}
		
		waitForExpectations(timeout: 5, handler: nil)
	
		
	}
	
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		apiUnderTest = nil
		super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
