//
//  ViewController.swift
//  MovieSearch
//

import UIKit

class SearchViewController: UIViewController {
	//MARK:- Properties
	weak var coordinator: SearchCoordinator?
	
	lazy var prevTableViewDataSource: PrevSearchResultsTableViewDataSource = {
		return PrevSearchResultsTableViewDataSource()
	}()

	var searchView: SearchView = {
		var search = SearchView()
		return search
	}()
	
	//MARK:- Methods
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
		searchView.cancelButton.addTarget(nil, action: #selector(cancelButtonPressed), for: .touchUpInside)
		//set delegates
		searchView.searchField.delegate = self
		searchView.prevResultsTableView.delegate = self
		searchView.prevResultsTableView.dataSource = prevTableViewDataSource
		//reloads tableview and adjust constraints dependant on data
		DispatchQueue.main.async {
			self.reloadTableViewContent()
		}
	}
	
	@objc func cancelButtonPressed() {
		cancelSearch()
	}
	
	func cancelSearch() {
		coordinator?.http.cancelTask()
		searchView.searchCancelled()
	}
	
	///Reloads the table view based on the new content height.
	func reloadTableViewContent() {
		searchView.prevTableViewHeight?.isActive = false
		searchView.prevResultsTableView.reloadData()
		searchView.prevTableViewHeight?.constant = searchView.prevResultsTableView.contentSize.height
		searchView.prevTableViewHeight?.isActive = true
		
	}
}

//MARK:- UItextfield delegate
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

//MARK:- UItableview delegate
extension SearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as? PrevResultTableViewCell
		searchView.searchField.text = cell?.titleLabel.text
	}
}

extension SearchViewController: Storyboarded {}
