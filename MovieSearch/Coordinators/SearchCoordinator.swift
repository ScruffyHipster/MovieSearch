//
//  MainCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Manages the Search controller tab in the app
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
	
	func searchResultsInit(with results: [SearchResultDetails]) {
		
		let child = SearchResultsCoordiantor(navController: navigationController)
		child.searchResults = results
		child.resultDataHandler = resultDataHandler
		child.parentCoordinator = self
		childCoordinator.append(child)
		//We populate the search results array first. This can then handle either showing no results error or the data.
		child.populateResults()
		
	}
	
	
}

extension SearchCoordinator {
	
	func searchForMovies(searchTerm: String) {
		let url = http.createUrl(searchParam: .search, searchTerm: searchTerm)
		print("url is \(url)")
		http.makeRequest(url: url, for: SearchResultDetails.self) { (success, results) -> (Void) in
			if success {
				self.searchResultsInit(with: results as! [SearchResultDetails])
				print(results)
			} else {
				self.searchResultsInit(with: [])
				print(results)
			}
		}
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
	}
	
}
