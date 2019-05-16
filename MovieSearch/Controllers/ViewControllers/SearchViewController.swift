//
//  ViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
	
	weak var coordinator: SearchCoordinator?

	var searchView: SearchView = {
		var search = SearchView()
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpView()
	}
	
	///Sets up the view initially
	func setUpView() {
		self.navigationController?.navigationBar.isHidden = true
		setUpSearchView()
	}


}

//MARK:- View setup methods
extension SearchViewController {
	
	private func setUpSearchView() {
		searchView.frame = self.view.bounds
		view.addSubview(searchView)
		NSLayoutConstraint.activate([
			searchView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
			searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
			searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
			searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
			])
	}
	
}

extension SearchViewController: Storyboarded {
	
}
