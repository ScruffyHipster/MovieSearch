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
		startViewControllers()
		viewControllers = [searchCoordinator.navigationController, savedCoordinator.navigationController]
        // Do any additional setup after loading the view.
    }
	
	func startViewControllers() {
		searchCoordinator.start()
		savedCoordinator.start()
	}
	
	

}
