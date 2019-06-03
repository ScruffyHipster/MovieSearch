//
//  MovieSearchSlowTests.swift
//  MovieSearchSlowTests
//

import XCTest
@testable import MovieSearch

class MovieSearchSlowTests: XCTestCase {
	
	var sessionUnderTest: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		sessionUnderTest = nil
		super.tearDown()
    }

	func testValidCallToOMDBGetStatusCode200() {
		//Given
		let onlineUrl = URL(string: "https:www.omdbapi.com/?i=tt0848228&apikey=592d6c41")
		let promise = expectation(description: "Status code: 200")
		
		//when
		let dataTask = sessionUnderTest.dataTask(with: onlineUrl!) { (data, response, error) in
			//then
			if let error = error {
				XCTFail("Error: \(error.localizedDescription)")
				return
			} else if let response = response as? HTTPURLResponse {
				if response.statusCode == 200 {
					promise.fulfill()
				} else {
					XCTFail("Error: Status code returned: \(response.statusCode) incorrect \(String(describing: error?.localizedDescription)))")
				}
			}
		}
		dataTask.resume()
		waitForExpectations(timeout: 5, handler: nil)
	}
	
	func testForCompletedCallToServer() {
		//given
		let url = URL(string: "https:www.omdbapi.com/?i=tt0848228&apikey=592d6c41")
		let promise = expectation(description: "completionHandler invoked")
		var statusCode: Int?
		var responseError: Error?
		
		//when
		let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
			if let response = response as? HTTPURLResponse {
				statusCode = response.statusCode
				responseError = error
				promise.fulfill()
			}
		}
		dataTask.resume()
		
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertNil(responseError)
		XCTAssertEqual(statusCode, 200)
	}

}
