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
class SavedCoordinator: NSObject, Coordinator {
	
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
		navigationController.delegate = self
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
		savedViewController?.reloadTableView()
	}
	
	func didSelectMovie(_ movie: Movie) {
		initiateDetails(with: movie)
	}
}

extension SavedCoordinator: DismissCoordinatorProtocol {
	func dismiss(_ coordinator: Coordinator) {
		childDidFinish(remove: coordinator)
	}
	
	
}

extension SavedCoordinator: UINavigationControllerDelegate {
		
	///This functions removes the child coordinator from the child array.
	func childDidFinish(remove child: Coordinator?) {
		for(index, coordinator) in childCoordinator.enumerated() {
			if coordinator === child {
				childCoordinator.remove(at: index)
				break
			}
		}
	}
	
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		//Get the name of the vc were moving from
		guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
		//if were still here on the vc do nothing
		if navigationController.viewControllers.contains(fromVC) {
			return
		}
		//else we check if the vc is in the child array and remove it when we've navigated back
		if let detailsVC = fromVC as? DetailsViewController {
			childDidFinish(remove: detailsVC.coordinator)
		}
	}
	
}
