//
//  SearchResultsCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Manages the search results view controller and logic
class SearchResultsCoordiantor: Coordinator {
	
	weak var parentCoordinator: SearchCoordinator?
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var resultDataHandler: ResultsDataHandler?
	
	var searchResults: InitialSearchResultDetails?
	
	var http: HttpAPI?
	
	init(navController: UINavigationController) {
		self.navigationController = navController
	}
	
	internal func start() {
		let searchResultsVC = SearchResultsViewController.instantiate()
		searchResultsVC.searchResultCollectionViewDelegate.resultsHandler = resultDataHandler
		searchResultsVC.searchResultCollectionViewDelegate.delegate = parentCoordinator
		navigationController.pushViewController(searchResultsVC, animated: true)
	}
	
	///Adds the data to the array. 
	func populateResults() {
		guard let results = searchResults else {
			//We can show an error or no results sign if this fails
			return
		}
		
		//else populate the collection view with the search results
		resultDataHandler?.populateDataWith(data: results.search)
		
		DispatchQueue.main.async {
			self.start()
		}
	
	}
}
