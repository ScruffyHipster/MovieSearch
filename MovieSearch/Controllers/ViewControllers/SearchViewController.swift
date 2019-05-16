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

	var searchView: SearchView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpView()
	}
	
	///Sets up the view initially
	func setUpView() {
		self.navigationController?.navigationBar.isHidden = true
		
		searchView = SearchView(frame: self.view.bounds)
		
		view.addSubview(searchView)
	}


}

extension SearchViewController: Storyboarded {
	
}
