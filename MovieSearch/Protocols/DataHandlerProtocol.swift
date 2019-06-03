//
//  DataHandlerProtocol.swift
//  MovieSearch
//

import Foundation

///Provides default methods for interfacing with the results handler class.
protocol DataHandlerProtocol {
	var resultsHandler: ResultsDataHandler? {get set}
	var resultsData: [AnyObject]? {get}
}

