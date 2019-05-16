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
		resultsData = data as [AnyObject]
	}
	
	///Return the results data
	func retriveDataFromHandeler<T>() -> [T] {
		guard let data = resultsData else {return []}
		return data as! [T]
	}
 }
