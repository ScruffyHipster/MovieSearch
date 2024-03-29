//
//  DetailsCoordinator.swift
//  MovieSearch
//

import Foundation
import UIKit
import CoreData

///Handles the details view controller. This is a child of Search Coordinator and Saved Coordinator.
class DetailsCoordinator: Coordinator {
	
	//MARK:- Properties
	weak var parentCoordinator: SearchCoordinator?
	weak var savedParentCoordinator: SavedCoordinator?
	weak var dismissDelegate: DismissCoordinatorProtocol?
	var childCoordinator = [Coordinator]()
	var navigationController: UINavigationController
	var detailsViewController: DetailsViewController?
	var managedObject: NSManagedObjectContext?
	var movieDetails: Any?
	var http: HttpAPI?
	var viewUse: DetailsViewUse?

	///Custom Init. This is used to determine if controller is showing a search result or saved result
	init<T>(navController: UINavigationController, viewUse: DetailsViewUse, movieDetails: T) {
		self.navigationController = navController
		if viewUse == .search {
			self.movieDetails = movieDetails as? MovieDetails
			self.viewUse = viewUse
			return
		} else {
			self.movieDetails = movieDetails as! Movie
			self.viewUse = viewUse
		}
		
	}
	
	//MARK:- Methods
	func setUp() {
		guard movieDetails != nil else {return}
		DispatchQueue.main.async {
			self.start()
		}
	}
	
	internal func start() {
		detailsViewController = DetailsViewController.instantiate()
		guard let detailsVC = detailsViewController else {return}
		detailsVC.coordinator = self
		detailsVC.movieDetails = movieDetails
		detailsVC.viewUse = viewUse
		navigationController.present(detailsVC, animated: true, completion: nil)
	}

	func dismissDetailsVC() {
		//DetailsVC is presented modally so we use this delegate to send a message to its delegate to remove it from the navigation stack.
		dismissDelegate?.dismiss(detailsViewController!.coordinator!)
	}
	
	func saveMovie() {
		parentCoordinator?.save(movie: movieDetails as! MovieDetails, closure: { (success) in
			if success {
				return
			} else {
				let alert = UIAlertController.createAlert(alertTitle: "Couldn't save this!!", alertScenario: .error, actionTitle: "OK")
				detailsViewController?.present(alert, animated: true)
			}
		})
	}
	
	func retriveImages(url: String) -> String {
		//retrives image from local disk
		let fileManager = FileManager.default
		var urlToReturn = ""
		let image = fileManager.localFileUrl(for: URL(string: url)!).absoluteString
		urlToReturn = image
		return urlToReturn
	}
}



