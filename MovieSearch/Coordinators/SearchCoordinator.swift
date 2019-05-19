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
class SearchCoordinator: Coordinator {
	
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
		
		//Populate data this will come from cloudkit eventually
		resultDataHandler.populateDataWith(data: ["One", "Two", "Three"])
		
		//Pass the delegate the resultHandler object
		searchVC.prevTableViewDelegate.resultsHandler = resultDataHandler
		
		navigationController.viewControllers = [searchVC]
	}
	
	
}

extension SearchCoordinator {
	
	func searchForMovies(searchTerm: String) {
		let url = http.createUrl(searchParam: .search, searchTerm: searchTerm)
		print("url is \(url)")
		http.makeRequest(url: url, for: SearchResultDetails.self) { (success, results) -> (Void) in
			if success {
				print("success")
				print(results)
			} else {
				print("failed")
			}
		}
	}
	
}
