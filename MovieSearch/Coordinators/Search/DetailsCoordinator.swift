//
//  DetailsCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit
import CoreData

///Handles the details view controller. This is a child of Search Coordinator.
class DetailsCoordinator: Coordinator {
	
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
		detailsVC.viewUse = viewUse
		navigationController.present(detailsVC, animated: true, completion: nil)
		
	}

	///DetailsVC is presented modally so we use this delegate to send a message to its delegate to remove it from the stack.
	func dismissDetailsVC() {
		dismissDelegate?.dismiss(detailsViewController!.coordinator!)
	}
	
	func retriveImages(url: String) -> String {
		//FileManager
		let fileManager = FileManager.default
		var urlToReturn = ""
		do {
			//Gets path to the folder in the documents directory using global constant --
			//TODO:- needs to change
			let path = try fileManager.contentsOfDirectory(at: filePath, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
			//retrives the image from the document directory
			let image = fileManager.localFileUrl(for: URL(string: url)!).absoluteString
			urlToReturn = image
			print(image)
			print(path)
		} catch {
			print("Error: \(error.localizedDescription)")
		}
		return urlToReturn
	}
}



