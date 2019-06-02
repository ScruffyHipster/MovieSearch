//
//  ResultsDataHandler.swift
//  MovieSearch
//
//  Created by Tom Murray on 16/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation

///Handles the population and retrival of data in data sources such as tableview and collectionview. Can handle any data type so can be resused in many areas.
class ResultsDataHandler {
	
	///Used to store the populated results.
	var resultsData: [AnyObject]?
	
	///Populates the resultsData array with data passed in.
	func populateDataWith<T>(data: [T]) {
		clearArray()
		resultsData = data as [AnyObject]
	}
	
	///Returns results that are present in the resultsData array.
	func retriveDataFromHandeler<T>() -> [T] {
		guard let data = resultsData else {return []}
		return data as! [T]
	}
	
	///Clears the array for use, a housekeeping function to prevent any data mismatches.
	private func clearArray() {
		guard let array = resultsData else {return}
		if !array.isEmpty {
			resultsData = []
		}
	}

 }
