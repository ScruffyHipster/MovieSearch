//
//  MovieSearchTests.swift
//  MovieSearchTests
//

import XCTest
@testable import MovieSearch

class MovieSearchTests: XCTestCase {

	var searchCoodinator: SearchCoordinator!
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		searchCoodinator = SearchCoordinator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		searchCoodinator = nil
    }
	
	func testResultsHaandlerArrayIsNilAtStart() {
		//Check array is nil at startup
		var array = [Any]()
		array = searchCoodinator.resultDataHandler.retriveDataFromHandeler()
		XCTAssert(array.count == 0, "Array is nil")
	}
	
	func testPrevResultsArrayIsNeverGreaterThanThree() {
		let dataSource = searchCoodinator.searchViewController?.prevTableViewDataSource
		var array = [String]()
		array = dataSource?.resultsHandler?.retriveDataFromHandeler() ?? [] as [String]
		XCTAssert(array.count < 3, "Passed")
	}
	
	

}
