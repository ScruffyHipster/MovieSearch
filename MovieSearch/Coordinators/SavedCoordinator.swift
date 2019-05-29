//
//  SavedCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit
import CoreData

///Manges the Saved controller tab and it child coordinators in the saved heirachy.
class SavedCoordinator: Coordinator {
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var savedViewController: SavedViewController?
	
	var resultDataHandler = ResultsDataHandler()
	
	var managedObject: NSManagedObjectContext?
	
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		managedObject = appDelegate.managedObject
	}
	
	func start() {
		//starts up the starting View Controller and then adds it to the navcontroller.
		fetch()
		setUpSavedMovieObserver()
	}
	
	func savedVCInit(with movies: [Movie]) {
		savedViewController = SavedViewController.instantiate()
		guard let savedVC = savedViewController else {return}
		savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "savedIcon"), tag: 1)
		savedVC.coordinator = self
		
		savedVC.savedTableViewDelegate.resultsHandler = resultDataHandler
		
		savedVC.savedTableViewDelegate.delegate = self
		
		navigationController.viewControllers = [savedVC]
		
		resultDataHandler.populateDataWith(data: movies)
		
	}
	
	func initiateDetails(with movie: Movie) {
		///Sets up the details view to see movie details
		let child = DetailsCoordinator(navController: navigationController, viewUse: .saved, movieDetails: movie)
		child.savedParentCoordinator = self
		child.dismissDelegate = self
		childCoordinator.append(child)
		child.setUp()
	}
}

extension SavedCoordinator {
	
	@objc func fetch() {
		let fetchRequest = NSFetchRequest<Movie>()
		let entity = Movie.entity()
		fetchRequest.entity = entity
		do {
			let fetchedMovies = try managedObject?.fetch(fetchRequest)
			guard let movies = fetchedMovies else {
				savedVCInit(with: [])
				return
			}
			savedVCInit(with: movies)
		} catch {
			
		}
		
 	}
	
}

extension SavedCoordinator {
	func setUpSavedMovieObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: ObserverValues.saveMovie.notificationName, object: nil)
	}
}

extension SavedCoordinator: SavedResultsSelectionDelegate {
	
	func deleteMovie(_ movie: Movie) {
		self.managedObject?.delete(movie)
		FileManager().removeFileFromDisk(from: movie.posterUrl!)
		do {
			try self.managedObject?.save()
		} catch let error {
			print(error)
		}
	}
	
	func didSelectMovie(_ movie: Movie) {
		initiateDetails(with: movie)
	}
}

extension SavedCoordinator: DismissCoordinatorProtocol {
	func dismiss(_ coordinator: Coordinator) {
		//still need to implement
		print("going to dismiss")
	}
	
	
}
