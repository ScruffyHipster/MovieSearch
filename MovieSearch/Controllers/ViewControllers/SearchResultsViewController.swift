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
		searchResultView.collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setUpNavBar()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.navigationBar.isHidden = true
	
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		let collection = searchResultView.collectionView
		guard let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout else {return}
		
		if UIDevice.current.orientation.isLandscape {
			
			collection.isPagingEnabled = false
			layout.invalidateLayout()
			searchResultView.layoutIfNeeded()
			collection.reloadData()
		
		} else if UIDevice.current.orientation.isPortrait {
			
			collection.isPagingEnabled = true
			layout.invalidateLayout()
			searchResultView.layoutIfNeeded()
			collection.reloadData()
			
		}
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
