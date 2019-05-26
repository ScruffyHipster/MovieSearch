//
//  DetailsCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Handles the details view controller. This is a child of Search Coordinator.
class DetailsCoordinator: Coordinator {
	
	weak var parentCoordinator: SearchCoordinator?
	
	weak var dismissDelegate: DismissCoordinatorProtocol?
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var detailsViewController: DetailsViewController?
	
	var movieDetails: MovieDetails?
	
	var http: HttpAPI?
	

	
	init(navController: UINavigationController, movieDetails: MovieDetails) {
		self.navigationController = navController
		self.movieDetails = movieDetails
	}
	
	func setUp() {
		guard movieDetails != nil else {
			print("no details")
			return}
		DispatchQueue.main.async {
			self.start()
		}
	}
	
	internal func start() {
		detailsViewController = DetailsViewController.instantiate()
		guard let detailsVC = detailsViewController else {return}
		detailsVC.coordinator = self
		detailsVC.movieDetails = movieDetails
		navigationController.present(detailsVC, animated: true, completion: nil)
		
	}

	///DetailsVC is presented modally so we use this delegate to send a message to its delegate to remove it from the stack.
	func dismissDetailsVC() {
		dismissDelegate?.dismiss(detailsViewController!.coordinator!)
	}
	
	
	
}

