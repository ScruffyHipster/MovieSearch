//
//  SavedViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
	
	weak var coordinator: SavedCoordinator?

	lazy var savedTableViewDelegate: SavedResultsTableViewDelegate = {
		var delegate = SavedResultsTableViewDelegate()
		return delegate
	}()
	
	var savedView: SavedView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		setUpView()
    }
	 
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		if UIDevice.current.orientation.isLandscape {
			savedView?.landscape()
		}
		if UIDevice.current.orientation.isPortrait {
			savedView?.portrait()
		}
	}

	//MARK:- Methods

	func setUpView() {
		savedView = SavedView(frame: view.bounds)
		view.addSubview(savedView!)
		savedView?.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
		savedView?.savedTableViewDelegate = savedTableViewDelegate
		DispatchQueue.main.async {
			self.reloadTableView()
		}
		
	}
	
	func reloadTableView() {
		savedView?.savedResultsTableViewHeight?.isActive = false
		savedView?.savedResultsTableViewHeight?.constant = (savedView?.savedMoviesTableView.contentSize.height)!
		savedView?.savedResultsTableViewHeight?.isActive = true
		savedView?.savedMoviesTableView.reloadData()
	}

}

extension SavedViewController: Storyboarded {
	
}
