//
//  coordinatorSetTest.swift
//  MovieSearch
//
//  Created by Tom Murray on 01/06/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
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
		
		if mainTabCoordinator.viewControllers!.count == 2 {
			XCTAssertEqual(mainTabCoordinator.viewControllers?.count, 2)
		} else {
			XCTFail("Failed")
		}
	}
	
	func testCoordinatorsCreated() {
		if viewControllerOne.coordinator == nil, viewControllerTwo.coordinator == nil {
			XCTAssert(true, "Passed")
		} else {
			XCTFail("failed")
		}
	}

}
