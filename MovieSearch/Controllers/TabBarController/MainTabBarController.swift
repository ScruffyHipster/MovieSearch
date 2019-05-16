//
//  MainTabBarController.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	
	let searchCoordinator = SearchCoordinator()
	let savedCoordinator  = SavedCoordinator()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tabBarSetUp()
		startViewControllers()
		viewControllers = [searchCoordinator.navigationController, savedCoordinator.navigationController]
    }
	
	func startViewControllers() {
		searchCoordinator.start()
		savedCoordinator.start()
	}
	
	///Set the tab bar to a transparent state
	func tabBarSetUp() {
		self.tabBar.backgroundImage = UIImage()
		self.tabBar.layer.borderColor = UIColor.clear.cgColor
		tabBar.layer.borderWidth = 0.5
		tabBar.clipsToBounds = true
		self.tabBar.barTintColor = .clear
		self.tabBar.tintColor = .white
	}
	
	

}
