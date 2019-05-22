//
//  SearchResultsCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


class SearchResultsCoordiantor: Coordinator {
	
	weak var parentCoordinator: SearchCoordinator?
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var resultDataHandler: ResultsDataHandler?
	
	var searchResults: [SearchResultDetails]?
	
	init(navController: UINavigationController) {
		self.navigationController = navController
	}
	
	func start() {
		let searchResultsVC = SearchResultsViewController.instantiate()
		navigationController.pushViewController(searchResultsVC, animated: true)
	}
	
	
	
	///Adds the data to the array. 
	func populateResults() {
		guard let results = searchResults else {
			//We can show an error or no results sign if this fails
			return
		}
		//else populate the collection view with the search results
		resultDataHandler?.populateDataWith(data: results)
		DispatchQueue.main.async {
			self.start()
		}
	
	}
	
	
	
}
