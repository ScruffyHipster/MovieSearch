//
//  HttpAPITest.swift
//  MovieSearchTests
//
//  Created by Tom Murray on 24/06/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import XCTest
@testable import MovieSearch

class HttpAPITest: XCTestCase {

	private var http = HttpAPI()
	private var urlRequest: URLRequest!
	private let term = "Guardians"
	
	func testCreatingURL() {
		
		urlRequest = http.createUrl(searchParam: .search, searchTerm: term)
		
		XCTAssertEqual(urlRequest, URLRequest(url: URL(string: "https://www.omdbapi.com/?s=guardians&apikey=592d6c41")!))
	}
	
	
	func testHttpRequest() {
		let promise = expectation(description: "Success")
		var searchResults: InitialSearchResultDetails!
		urlRequest = http.createUrl(searchParam: .search, searchTerm: term)
		http.makeRequest(url: urlRequest, for: InitialSearchResultDetails.self) { (success, results, error) -> (Void) in
			guard error == nil else {
				XCTFail("Failed due to error \(error!.localizedDescription)")
				return
			}
			guard success, let data = results  else {
				XCTFail("Failed with success as \(success) and no data")
				return
			}
			XCTAssertNotNil(data)
			searchResults = data
			promise.fulfill()
		}
		waitForExpectations(timeout: 10, handler: nil)
		XCTAssert(searchResults != nil)
	}
}
