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
		navigationController.viewControllers = [searchVC]
	}
	
	
	
}
