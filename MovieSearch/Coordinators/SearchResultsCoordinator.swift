//
//  SearchResultsCoordinator.swift
//  MovieSearch
//

import Foundation
import UIKit
import CoreData

///Manages the search results view controller and logic. This is a child of Search Coordinator.
class SearchResultsCoordiantor: Coordinator {
	//MARK:- Properties
	weak var parentCoordinator: SearchCoordinator?
	var childCoordinator = [Coordinator]()
	var navigationController: UINavigationController
	var resultDataHandler: ResultsDataHandler?
	var searchResults: InitialSearchResultDetails?
	var http: HttpAPI?
	var managedObject: NSManagedObjectContext?
	
	//MARK:- Init Methods
	init(navController: UINavigationController) {
		self.navigationController = navController
	}
	
	//MARK:- Methods
	internal func start() {
		let searchResultsVC = SearchResultsViewController.instantiate()
		searchResultsVC.coordinator = self
		searchResultsVC.searchResultCollectionViewDelegate.resultsHandler = resultDataHandler
		searchResultsVC.searchResultCollectionViewDelegate.delegate = parentCoordinator
		navigationController.pushViewController(searchResultsVC, animated: true)
	}
	
	///Adds the data to the array. 
	func populateResults() {
		guard let results = searchResults else {
			return
		}
		//else populate the collection view with the search results
		resultDataHandler?.populateDataWith(data: results.search)
		DispatchQueue.main.async {
			self.start()
		}
	}
	
	func save(movie: MovieDetails, closure: @escaping (Bool) -> ()) {
		parentCoordinator?.save(movie: movie, closure: { (success) in
			if success {
				closure(true)
			} else {
				closure(false)
			}
		})
	}
}
