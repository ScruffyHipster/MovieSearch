//
//  MainCoordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit
import CoreData

///Manages the Search controller tab in the app and child coordinator in the search heirachy
class SearchCoordinator: NSObject, Coordinator {
	//MARK:- Properties
	var childCoordinator = [Coordinator]()
	var navigationController: UINavigationController
	var searchViewController: SearchViewController?
	var resultDataHandler = ResultsDataHandler()
	var http = HttpAPI()
	var managedObject: NSManagedObjectContext?
	var previousSearches = [String]()
	let manager = FileManager.default
	
	//MARK:- Init Methods
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		managedObject = appDelegate.managedObject
	}
	
	//MARK:- Methods
	func start() {
		//starts up the starting View Controller and then adds it to the navcontroller.
		fetchMovieSearches()
		searchVCInit()
		navigationController.delegate = self
	}
	
	func searchVCInit() {
		searchViewController = SearchViewController.instantiate()
		guard let searchVC = searchViewController else {return}
		searchVC.tabBarItem = UITabBarItem(title: "search", image: UIImage(named: "searchIcon"), tag: 0)
		searchVC.coordinator = self
		
		//Pass the delegate the resultHandler object
		searchVC.prevTableViewDataSource.resultsHandler = resultDataHandler
		resultDataHandler.populateDataWith(data: previousSearches)
		
		navigationController.viewControllers = [searchVC]
	}
	
	///Sets up the search results view
	func searchResultsInit(with results: InitialSearchResultDetails?) {
		let child = SearchResultsCoordiantor(navController: navigationController)
		child.managedObject = managedObject
		child.searchResults = results
		child.resultDataHandler = resultDataHandler
		child.populateResults()
		child.parentCoordinator = self
		child.http = http
		childCoordinator.append(child)
	}
	
	///Sets up the details view to see movie details
	func detailsViewInit(with details: MovieDetails) {
		let child = DetailsCoordinator(navController: navigationController, viewUse: .search, movieDetails: details)
		child.parentCoordinator = self
		child.dismissDelegate = self
		child.http = http
		childCoordinator.append(child)
		child.setUp()
	}
	
	func formatSearch(searchTerm: String) -> String {
		if searchTerm.last!.isWhitespace {
			return String(searchTerm.dropLast())
		}
		return searchTerm
	}
	
	func updatePrevSearchesTableView() {
		searchViewController?.reloadTableViewContent()
	}
}

//SearchCoordinator Network requests
extension SearchCoordinator {
	///Used as the inital search for user inputted search term
	func searchForMovies(searchTerm: String) {
		let url = http.createUrl(searchParam: .search, searchTerm: searchTerm)
		self.saveSearch(search: searchTerm)
		http.makeRequest(url: url, for: InitialSearchResultDetails.self) { [weak self] (success, results: InitialSearchResultDetails?, error) -> (Void) in
			if success {
				self?.searchResultsInit(with: results!)
				self?.fetchMovieSearches()
			} else {
				DispatchQueue.main.async {
					let alert = UIAlertController(title: "Error", message: "No results for that search! Please try again.", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
						self?.searchViewController?.cancelSearch()
					}))
					self?.searchViewController?.present(alert, animated: true)
				}
			}
		}
	}
	
	func saveSearch(search: String) {
		//Save the search here for displaying in the prev search table
		let term = formatSearch(searchTerm: search)
		for searches in previousSearches where searches == term {
			return
		}
		if previousSearches.count == 3 {
			previousSearches.remove(at: 0)
		}
		previousSearches.append(term)
		resultDataHandler.populateDataWith(data: previousSearches)
		do {
			let data = try NSKeyedArchiver.archivedData(withRootObject: previousSearches, requiringSecureCoding: false)
			var path = getDocumentsDirectory().appendingPathComponent("prevSearches")
			path.appendPathExtension("search")
			try data.write(to: path)
		} catch {
			print("Issue saving file \(error)")
		}
		DispatchQueue.main.async {
			self.updatePrevSearchesTableView()
			self.searchViewController?.searchView.prevResultsTableView.reloadData()
		}
	}
	
	func fetchMovieSearches() {
		let url = getDocumentsDirectory()
		do {
			let urlPath = try manager.contentsOfDirectory(at: url, includingPropertiesForKeys: [], options: .skipsHiddenFiles).filter({$0.pathExtension == "search"})
			for url in urlPath {
				let data = manager.contents(atPath: url.path)
				if let data = data {
					previousSearches = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [String]
				}
			}
		} catch {
			print("error")
			let alert = UIAlertController.createAlert(alertTitle: "Error loading previous searches", alertScenario: .notification(notificationMessage: "Please restart the application if issue persists."), actionTitle: "OK")
			searchViewController?.present(alert, animated: true)
		}
	}
	
	///Used to fetch specific movie
	func fetchDetailsForMovie(with id: String) {
		let url = http.createUrl(searchParam: .id, searchTerm: id)
		http.makeRequest(url: url, for: MovieDetails.self, closure: { (success, result: MovieDetails?, error) -> (Void) in
			if success {
				self.detailsViewInit(with: result!)
			}
		})
	}
	
}

extension SearchCoordinator: SearchResultsSelectionDelegate {
	func didSelectMovieAt(_ IMDBid: String) {
		fetchDetailsForMovie(with: IMDBid)
	}
}

extension SearchCoordinator: DismissCoordinatorProtocol {
	func dismiss(_ coordinator: Coordinator) {
		childDidFinish(remove: coordinator)
	}
}

extension SearchCoordinator: UINavigationControllerDelegate {
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
		if let searchResultsVC = fromVC as? SearchResultsViewController {
			childDidFinish(remove: searchResultsVC.coordinator)
		}
		if let detailsVC = fromVC as? DetailsViewController {
			childDidFinish(remove: detailsVC.coordinator)
		}
	}
	
}

//CoreData Persitence Layer
extension SearchCoordinator {
	func save(movie: MovieDetails, closure: (Bool) -> ()){
		//save the movie details to CoreData
		guard let managedObject = managedObject else {return}
		let savedMovie = Movie(context: managedObject)
		savedMovie.posterUrl = movie.poster
		savedMovie.movieDirector = movie.director
		savedMovie.movieActor = movie.actors
		savedMovie.movieTitle = movie.title
		savedMovie.movieWriters = movie.writer
		savedMovie.movieRating = movie.imdbRating
		savedMovie.moviePlot = movie.plot
		saveToLocalDisk(url: movie.poster)
		do {
			try managedObject.save()
		} catch{
			closure(false)
		}
		closure(true)
		postSavedNotification()
	}

	func delete(movie: Movie, closure: (Bool) -> ()) {
		guard let managedObject = managedObject else {
			return
		}
		managedObject.delete(movie)
		do {
			try managedObject.save()
		} catch {
			let alert = UIAlertController.createAlert(alertTitle: "Error deleting movie", alertScenario: .notification(notificationMessage: "Try removing the movie again, if the issue persists, restart the application"), actionTitle: "OK")
			searchViewController?.present(alert, animated: true)
		}
	}
	
	func saveToLocalDisk(url: String) {
		http.downloadImage(url)
	}

	func postSavedNotification() {
		//posts notification to saved view to update table view
		let notifiction = ObserverValues.saveMovie.notificationName
		NotificationCenter.default.post(name: notifiction, object: nil)
	}
}
