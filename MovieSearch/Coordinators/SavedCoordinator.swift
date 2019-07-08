//
//  SavedCoordinator.swift
//  MovieSearch
//

import UIKit
import CoreData

///Manges the Saved controller tab and it child coordinators in the saved heirachy.
class SavedCoordinator: NSObject, Coordinator {
	//MARK:- Properties
	var childCoordinator = [Coordinator]()
	var navigationController: UINavigationController
	var savedViewController: SavedViewController?
	var resultDataHandler = ResultsDataHandler()
	var managedObject: NSManagedObjectContext?
	
	//MARK:- Init methods
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		managedObject = appDelegate.managedObject
	}
	
	//MARK:- Methods
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
	
	func detailsVCInit(with movie: Movie) {
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
	///Used to listen for nortifcations of a result being saved.
	func setUpSavedMovieObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: ObserverValues.saveMovie.notificationName, object: nil)
	}
}

extension SavedCoordinator: SavedResultsSelectionDelegate {
	func deleteMovie(_ movie: Movie) {
		let alert = UIAlertController.createAlert(alertTitle: "Error removing movie", alertScenario: .notification(notificationMessage: "Please try again or try restarting the app! Sorry for the annoyance!"), actionTitle: "OK")
		self.managedObject?.delete(movie)
		FileManager().removeFileFromDisk(from: movie.posterUrl!, closure: { success in
			if !success {
				self.savedViewController?.present(alert, animated: true)
			}
		})
		do {
			try self.managedObject?.save()
		} catch {
			savedViewController?.present(alert, animated: true)
		}
		savedViewController?.reloadTableView()
	}
	
	func didSelectMovie(_ movie: Movie) {
		detailsVCInit(with: movie)
	}
}

extension SavedCoordinator: DismissCoordinatorProtocol {
	func dismiss(_ coordinator: Coordinator) {
		childDidFinish(remove: coordinator)
	}
}

extension SavedCoordinator: UINavigationControllerDelegate {
	/// This functions removes the child coordinator from the child array.
	///
	/// - Parameter child: child to remove from the array
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
