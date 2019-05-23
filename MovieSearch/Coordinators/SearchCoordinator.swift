//
//  MainCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Manages the Search controller tab in the app and subsequent views therafter
class SearchCoordinator: NSObject, Coordinator {
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var searchViewController: SearchViewController?
	
	var resultDataHandler = ResultsDataHandler()
	
	var http = HttpAPI()
	
	func start() {
		//starts up the starting View Controller and then adds it to the navcontroller.
		initiateSearchVC()
	}
	
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
	}
	
	func initiateSearchVC() {
		searchViewController = SearchViewController.instantiate()
		guard let searchVC = searchViewController else {return}
		searchVC.tabBarItem = UITabBarItem(title: "search", image: UIImage(named: "searchIcon"), tag: 0)
		searchVC.coordinator = self
		
		//Populate data this will come from cloudkit eventually and display previous successful searches made.
		
		resultDataHandler.populateDataWith(data: ["One", "Two", "Three"])
		
		//Pass the delegate the resultHandler object
		searchVC.prevTableViewDelegate.resultsHandler = resultDataHandler
		
		navigationController.viewControllers = [searchVC]
	}
	
	///Sets up the search results view
	func searchResultsInit(with results: InitialSearchResultDetails?) {
		let child = SearchResultsCoordiantor(navController: navigationController)
		
		//We populate the search results array first. This can then handle either showing no results error or the data.
		
		child.searchResults = results
		child.resultDataHandler = resultDataHandler
		child.populateResults()
		
		
		child.parentCoordinator = self
		child.http = http
		childCoordinator.append(child)
		
	}
	
	///Sets up the details view to see movie details
	func detailsViewInit(with details: MovieDetails) {
		let child = DetailsCoordinator(navController: navigationController, movieDetails: details)
		child.parentCoordinator = self
		child.http = http
		childCoordinator.append(child)
		child.setUp()
	}
	
}

extension SearchCoordinator {
	
	///Used as the inital search for user inputted search term
	func searchForMovies(searchTerm: String) {
		let url = http.createUrl(searchParam: .search, searchTerm: searchTerm)
		print("url is \(url)")
		http.makeRequest(url: url, for: InitialSearchResultDetails.self) { (success, results: InitialSearchResultDetails?, error) -> (Void) in
			if success {
				self.searchResultsInit(with: results!)
			} else {
				self.searchResultsInit(with: nil)
				print("Didn't retrive data")
			}
		}
	}
	
	///Used to fetch specific movie
	func fetchDetailsForMovie(with name: SearchResults) {
		let url = http.createUrl(searchParam: .title, searchTerm: name.imdbID)
		http.makeRequest(url: url, for: MovieDetails.self, closure: { (success, result: MovieDetails?, error) -> (Void) in
			if success {
				self.detailsViewInit(with: result!)
				print("result")
			} else {
				print("bad result")
			}
		})
	}
}


extension SearchCoordinator: SearchResultsSelectionDelegate {
	
	func didSelectMovieAt(_ indexPath: IndexPath) {
		//
	}
	
	
}



extension SearchCoordinator: UINavigationControllerDelegate {
	
	///This functions removes the child coordinator from the child array.
	func childDidFinish(remove child: Coordinator?) {
		for(index, coordinator) in childCoordinator.enumerated() {
			if coordinator === child {
				childCoordinator.remove(at: index)
				break
			}
		}
	}
	
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		//Get the name of the vc were moving from
		guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
		//if were still here on the vc do nothing
		if navigationController.viewControllers.contains(fromVC) {
			return
		}
		//else we check if the vc is in the child array and remove it when we've navigated back
		if let searchResultsVC = fromVC as? SearchResultsViewController {
			childDidFinish(remove: searchResultsVC.coordinator)
		}
		if let detailsVC = fromVC as? DetailsViewController {
			childDidFinish(remove: detailsVC.coordinator)
		}
	}
	
}
