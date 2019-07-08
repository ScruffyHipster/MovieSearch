//
//  ImageResizerTest.swift
//  MovieSearchTests
//
//  Created by Tom Murray on 24/06/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import XCTest
@testable import MovieSearch

class ImageResizerTest: XCTestCase {

	private var image: UIImage?
	private var placeHolder = UIImage(named: "posterPlaceholder")!
	
	func testImageResizing() {
		XCTAssert(image == nil)
		image = resizeImage(image: placeHolder, for: CGSize(width: 200, height: 200))
		XCTAssertEqual(image?.size, CGSize(width: 200, height: 200))
	}
}
