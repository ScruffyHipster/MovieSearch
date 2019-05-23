//
//  SearchResultsViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit



class SearchResultsViewController: UIViewController {
	
	weak var coordinator: SearchResultsCoordiantor?
	
	var searchResultView: SearchResultsView = {
		var view = SearchResultsView()
		return view
	}()
	
	var searchResultCollectionViewDelegate: SearchResultsCollectionViewDelegate = {
		return SearchResultsCollectionViewDelegate()
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpView()
		DispatchQueue.main.async {
			self.searchResultView.collectionView.reloadData()
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setUpNavBar()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.navigationBar.isHidden = true
	
	}
	
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		searchResultView.collectionView.collectionViewLayout.invalidateLayout()
		searchResultView.collectionView.reloadData()
	}
	
	private func setUpNavBar() {
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
	}
    
}

extension SearchResultsViewController: Storyboarded {
	
	private func setUpView() {
		searchResultView.collectionViewDelegate = searchResultCollectionViewDelegate
		view.addSubview(searchResultView)
		searchResultView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
		searchResultView.collectionView.reloadData()
	}
}
