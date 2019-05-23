//
//  DetailsCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


class DetailsCoordinator: Coordinator {
	
	weak var parentCoordinator: SearchCoordinator?
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var detailsViewController: DetailsViewController?
	
	var details: MovieDetails?
	
	var http: HttpAPI?
	
	init(navController: UINavigationController, movieDetails: MovieDetails) {
		self.navigationController = navController
		self.details = movieDetails
	}
	
	func setUp() {
		guard details != nil else {return}
		start()
	}
	
	internal func start() {
		
		detailsViewController = DetailsViewController.instantiate()
		guard let detailsVC = detailsViewController else {return}
		
		navigationController.pushViewController(detailsVC, animated: true)
	}
	
	
}
