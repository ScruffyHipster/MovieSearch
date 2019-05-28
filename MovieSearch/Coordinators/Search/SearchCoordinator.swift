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

///Manages the Search controller tab in the app and subsequent views therafter
class SearchCoordinator: NSObject, Coordinator {
	
	var childCoordinator = [Coordinator]()
	
	var navigationController: UINavigationController
	
	var searchViewController: SearchViewController?
	
	var resultDataHandler = ResultsDataHandler()
	
	var http = HttpAPI()
	
	var managedObject: NSManagedObjectContext?
	
	func start() {
		//starts up the starting View Controller and then adds it to the navcontroller.
		initiateSearchVC()
		navigationController.delegate = self
	}
	
	init(navController: UINavigationController = UINavigationController()) {
		self.navigationController = navController
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		managedObject = appDelegate.managedObject
	}
	
	func initiateSearchVC() {
		searchViewController = SearchViewController.instantiate()
		guard let searchVC = searchViewController else {return}
		searchVC.tabBarItem = UITabBarItem(title: "search", image: UIImage(named: "searchIcon"), tag: 0)
		searchVC.coordinator = self
		
		//Populate data this will come from cloudkit eventually and display previous successful searches made.
		
		resultDataHandler.populateDataWith(data: ["One", "Two", "Three"])
		
		//Pass the delegate the resultHandler object
		searchVC.prevTableViewDelegate.resultsHandler = resultDataHandler
		
		navigationController.viewControllers = [searchVC]
	}
	
	///Sets up the search results view
	func searchResultsInit(with results: InitialSearchResultDetails?) {
		let child = SearchResultsCoordiantor(navController: navigationController)
		
		//We populate the search results array first. This can then handle either showing no results error or the data.
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
	
}

//SearchCoordinator Network requests
extension SearchCoordinator {
	
	///Used as the inital search for user inputted search term
	func searchForMovies(searchTerm: String) {
		let url = http.createUrl(searchParam: .search, searchTerm: searchTerm)
		print("url is \(url)")
		http.makeRequest(url: url, for: InitialSearchResultDetails.self) { [weak self] (success, results: InitialSearchResultDetails?, error) -> (Void) in
			if success {
				self?.searchResultsInit(with: results!)
			} else {
				self?.searchResultsInit(with: nil)
				print("Didn't retrive data")
			}
		}
	}
	
	///Used to fetch specific movie
	func fetchDetailsForMovie(with id: String) {
		let url = http.createUrl(searchParam: .id, searchTerm: id)
		http.makeRequest(url: url, for: MovieDetails.self, closure: { (success, result: MovieDetails?, error) -> (Void) in
			if success {
				self.detailsViewInit(with: result!)
				print("result")
			} else {
				print("bad result")
			}
		})
	}
}


extension SearchCoordinator: SearchResultsSelectionDelegate {
	
	func didSelectMovieAt(_ IMDBid: String) {
		print("index path passed is \(IMDBid)")
		fetchDetailsForMovie(with: IMDBid)
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

extension SearchCoordinator: DismissCoordinatorProtocol {
	func dismiss(_ coordinator: Coordinator) {
		childDidFinish(remove: coordinator)
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
			//post an alert to the vc if issue saving
			closure(false)
		}
		closure(true)
		postSavedNotification()
	}
	
	func saveToLocalDisk(url: String) {
		print("saving image to disk")
		http.downloadImage(url)
	}

	func postSavedNotification() {
		let notifiction = ObserverValues.saveMovie.notificationName
		NotificationCenter.default.post(name: notifiction, object: nil)
	}
}
