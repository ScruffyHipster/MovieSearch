//
//  SavedCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///Manges the Saved controller tab in the app
class SavedCoordinator: Coordinator {
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var savedViewController: SavedViewController?
	
	var resultDataHandler = ResultsDataHandler()
	
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
	}
	
	func start() {
		//starts up the starting View Controller and then adds it to the navcontroller.
		initiateSavedVC()
	}
	
	func initiateSavedVC() {
		savedViewController = SavedViewController.instantiate()
		guard let savedVC = savedViewController else {return}
		savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "savedIcon"), tag: 1)
		savedVC.coordinator = self

		
		let savedMovies = ["one", "two", "three"]
		
		resultDataHandler.populateDataWith(data: savedMovies)
		
		savedVC.savedTableViewDelegate.resultsHandler = resultDataHandler
		
		navigationController.viewControllers = [savedVC]
	}
	
}
