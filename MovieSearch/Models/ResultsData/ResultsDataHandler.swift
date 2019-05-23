//
//  ResultsDataHandler.swift
//  MovieSearch
//
//  Created by Tom Murray on 16/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation

///Handler to manage the populate and distribution of data from a URLSession request.
class ResultsDataHandler {
	
	///Used to store the retrived results
	var resultsData: [AnyObject]?
	
	///Populate the resultsData Array with the data passed in
	func populateDataWith<T>(data: [T]) {
		clearArray()
		resultsData = data as [AnyObject]
	}
	
	private func clearArray() {
		guard let array = resultsData else {
			print("nothing in array")
			return}
		if !array.isEmpty {
			print("clearing array")
			resultsData = []
		}
	}
	
	///Return the results data
	func retriveDataFromHandeler<T>() -> [T] {
		guard let data = resultsData else {return []}
		return data as! [T]
	}
 }
