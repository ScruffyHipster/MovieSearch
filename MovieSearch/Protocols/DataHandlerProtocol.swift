//
//  DataHandlerProtocol.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation

///Provides default methods for interfacing with the results handler class.
protocol DataHandlerProtocol {
	var resultsHandler: ResultsDataHandler? {get set}
	var resultsData: [AnyObject]? {get}
}

