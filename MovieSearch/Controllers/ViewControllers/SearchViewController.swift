//
//  ViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
	
	//MARK:- Properties
	weak var coordinator: SearchCoordinator?
	
	lazy var prevTableViewDelegate: PrevSearchResultsTableViewDelegate = {
		return PrevSearchResultsTableViewDelegate()
	}()

	var searchView: SearchView = {
		var search = SearchView()
		return search
	}()
	
	//MARK:- Init Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		searchView.searchCancelled()
	}
	
	//MARK:- Functions
	///Sets up the view initially
	func setUpView() {
		self.navigationController?.navigationBar.isHidden = true
		setUpSearchView()
	}
	
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		if UIDevice.current.orientation.isLandscape {
			searchView.landscape()
		}
		if UIDevice.current.orientation.isPortrait {
			searchView.portrait()
		}
	}
}

//MARK:- View setup methods
extension SearchViewController {
	
	private func setUpSearchView() {
		
		searchView.frame = self.view.bounds
		view.addSubview(searchView)
		
		searchView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
		
		searchView.searchField.delegate = self
		
		//TODO:- See if below can be refactored
		
		//Pass the datasource to the tableView
		searchView.prevResultsTableView.delegate = prevTableViewDelegate
		searchView.prevResultsTableView.dataSource = prevTableViewDelegate
		
		//reloads tableview and adjust constraints dependant on data
		DispatchQueue.main.async {
			self.reloadTableViewContent()
		}
		searchView.cancelButton.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
	}
	
	@objc func cancelButtonPressed() {
		coordinator?.http.cancelTask()
		searchView.searchCancelled()
	}
	
	///Reloads the table view based on the new content height. Controller handles the change in size.
	private func reloadTableViewContent() {
		searchView.prevResultsTableView.reloadData()
		searchView.prevTableViewHeight?.isActive = false
		searchView.prevTableViewHeight?.constant = searchView.prevResultsTableView.contentSize.height
		searchView.prevTableViewHeight?.isActive = true
		
	}
}

extension SearchViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return searchView.searchField.resignFirstResponder()
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if searchView.searchField.text!.isEmpty {
			searchView.moveSearchBar(searching: true)
			searchView.toggleBlurView(true)
			UsableAniamtions.fade(layer: searchView.titleLabel.layer, from: 1.0, to: 0.6, duration: 0.5)
			UsableAniamtions.scaleDownFade(view: searchView.searchField.placeHolderLabel, direction: .up).startAnimation()
			UIView.animate(withDuration: 0.5) {
				self.searchView.prevResultsTableView.alpha = 1
			}
			UIView.animate(withDuration: 0.5) {
				self.searchView.layoutIfNeeded()
			}
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if searchView.searchField.text!.isEmpty {
			searchView.moveSearchBar(searching: false)
			searchView.toggleBlurView(false)
			UsableAniamtions.fade(layer: searchView.titleLabel.layer, from: 0.6, to: 1.0, duration: 0.5)
			UsableAniamtions.scaleDownFade(view: searchView.searchField.placeHolderLabel, direction: .down).startAnimation()
			UIView.animate(withDuration: 0.5) {
				self.searchView.layoutIfNeeded()
				self.searchView.prevResultsTableView.alpha = 0
			}
		} else {
			coordinator?.searchForMovies(searchTerm: searchView.searchField.text!)
			self.searchView.searchInitiatied()
		}
	}
}

extension SearchViewController: Storyboarded {
	
}
