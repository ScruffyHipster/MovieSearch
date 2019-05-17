//
//  SearchView.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///View for the main search tab bar view
class SearchView: UIView {
	
	//MARK:- Properties
	
	var backgroundContainerView: UIView = {
		let view = UIView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var searchField: SearchField = {
		return SearchField(frame: .zero)
	}()
	
	lazy var prevResultsTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = .clear
		tableView.register(PrevResultTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier.prevResultsCell.identity)
		tableView.isScrollEnabled = false
		tableView.alpha = 0.0
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	lazy var gradientLayer: CAGradientLayer = {
		var gradient = CAGradientLayer()
		gradient.colors = [GradientColors.blue.rgb.cgColor, GradientColors.green.rgb.cgColor]
		return gradient
	}()
	
	lazy var titleLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.text = "Movie Search"
		label.textAlignment = .left
		label.font = UsableFonts.titleFont
		label.textColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var blurView: UIVisualEffectView = {
		var view = UIVisualEffectView(frame: self.bounds)
		view.effect = UIBlurEffect(style: .dark)
		return view
	}()
	
	lazy var loadingIndicator: UIActivityIndicatorView = {
		var indicator = UIActivityIndicatorView()
		indicator.style = UIActivityIndicatorView.Style.white
		indicator.alpha = 0.0
		return indicator
	}()
	
	//Constraints are saved as variables so we can change the position of the search in landscape orientation.
	var searchBarTopConstraint: NSLayoutConstraint?
	var searchBarLeadingConstraint: NSLayoutConstraint?
	var searchBarTrailingConstraint: NSLayoutConstraint?
	
	//Constraint for the tableview height so we can change this upon loading of data
	var prevTableViewHeight: NSLayoutConstraint?

	//MARK:- Init methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	 	gradientLayer.frame = backgroundContainerView.bounds
		prevResultsTableView.backgroundColor = .clear
	}
	
	//MARK:- Methods
	
	func configure() {
		setupBackground()
		setUpTitle()
		setUpSearchField()
		setUpBlurView()
		setupTableView()
	}
	
	func toggleBlurView(_ show: Bool) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
			self.blurView.alpha = show ? 1.0 : 0.0
		}, completion: nil)
	}
	
	func moveSearchBar(searching: Bool) {
		self.searchBarTopConstraint?.isActive = false
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
			self.searchBarTopConstraint?.constant = searching ? 100 : 237
			self.searchBarTopConstraint?.isActive = true
		}, completion: nil)
	}
	
	

}

//View layer setups
extension SearchView {
	
	private func setupBackground() {
		addSubview(backgroundContainerView)
		backgroundContainerView.layer.addSublayer(gradientLayer)
		backgroundContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		NSLayoutConstraint.activate([
			backgroundContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			backgroundContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			backgroundContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			backgroundContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
			])
	}
	
	private func setUpTitle() {
		backgroundContainerView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
			titleLabel.heightAnchor.constraint(equalToConstant: 100)
			])
	}
	
	private func setUpSearchField() {
		backgroundContainerView.addSubview(searchField)
		searchBarTopConstraint = searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 237)
		searchBarLeadingConstraint = searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 34)
		searchBarTrailingConstraint = searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -34)
		NSLayoutConstraint.activate([
			searchBarTopConstraint!,
			searchBarLeadingConstraint!,
			searchBarTrailingConstraint!
			])
	}
	
	private func setUpBlurView() {
		backgroundContainerView.insertSubview(blurView, belowSubview: searchField)
		blurView.translatesAutoresizingMaskIntoConstraints = false
		blurView.alpha = 0.0
		NSLayoutConstraint.activate([
			blurView.topAnchor.constraint(equalTo: self.topAnchor),
			blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
			])
	}
	
	func setupTableView() {
		backgroundContainerView.addSubview(prevResultsTableView)
		prevTableViewHeight = prevResultsTableView.heightAnchor.constraint(equalToConstant: 100)
		NSLayoutConstraint.activate([
			prevTableViewHeight!,
			prevResultsTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
			prevResultsTableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.searchField.leadingAnchor),
			prevResultsTableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.searchField.trailingAnchor)
			])
	}
	
}

