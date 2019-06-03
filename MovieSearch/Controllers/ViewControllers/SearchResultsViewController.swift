//
//  SearchResultsViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit


class SearchResultsViewController: UIViewController {
	//MARK:- Properties
	weak var coordinator: SearchResultsCoordiantor?
	
	var searchResultView: SearchResultsView = {
		var view = SearchResultsView()
		return view
	}()
	
	var searchResultCollectionViewDelegate: SearchResultsCollectionViewDelegate = {
		return SearchResultsCollectionViewDelegate()
	}()

	//MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		setUpSuccessView()
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
		DispatchQueue.main.async {
			self.searchResultView.collectionView.reloadData()
		}
	}
	
	private func setUpNavBar() {
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.tintColor = UIColor.white
		self.title = "Search Results"
			
		let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
		navigationController?.navigationBar.largeTitleTextAttributes = attributes
		navigationController?.navigationBar.titleTextAttributes = attributes

	navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
	}
	
	private func setUpSuccessView() {
		searchResultView.collectionViewDelegate = searchResultCollectionViewDelegate
		view.addSubview(searchResultView)
		searchResultView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
		DispatchQueue.main.async {
			self.searchResultView.collectionView.reloadData()
		}
	}
}

extension SearchResultsViewController: Storyboarded {}
