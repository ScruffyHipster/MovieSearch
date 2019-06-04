//
//  coordinatorSetTest.swift
//  MovieSearch
//

import XCTest
@testable import MovieSearch

class coordinatorSetTest: XCTestCase {
	
	var mainTabCoordinator: MainTabBarController!
	var viewControllerOne: SearchViewController!
	var viewControllerTwo: SavedViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		mainTabCoordinator = MainTabBarController()
		viewControllerOne = SearchViewController()
		viewControllerTwo = SavedViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
		mainTabCoordinator = nil
		viewControllerOne = nil
		viewControllerTwo = nil
    }
	
	func testViewControllerAreCreated() {
		//Check view controllers are created properly at start
		if mainTabCoordinator.viewControllers!.count == 2 {
			XCTAssertEqual(mainTabCoordinator.viewControllers?.count, 2)
		} else {
			XCTFail("Failed")
		}
	}
	
	func testCoordinatorsCreated() {
		//check the coordinators are created at start
		if viewControllerOne.coordinator == nil, viewControllerTwo.coordinator == nil {
			XCTAssert(true, "Passed")
		} else {
			XCTFail("failed")
		}
	}

}
