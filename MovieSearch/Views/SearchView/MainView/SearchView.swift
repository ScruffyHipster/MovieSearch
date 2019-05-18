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
	
	var backgroundGradientContainerView: GradientContainerView = {
		let view = GradientContainerView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var searchField: SearchField = {
		return SearchField(frame: .zero)
	}()
	
	var searchGroupStackView: UIStackView = {
		var stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = UIStackView.Distribution.equalSpacing
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
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
	var searchStackViewTop: NSLayoutConstraint?
	var searchStackViewTrailing: NSLayoutConstraint?
	var searchStackViewLeading: NSLayoutConstraint?
	
	var titleLabelTop: NSLayoutConstraint?
	var titleLabelLeading: NSLayoutConstraint?
	var titleLabelTrailing: NSLayoutConstraint?
//
	//Constraint for the tableview height so we can change this upon loading of data
	var prevTableViewHeight: NSLayoutConstraint?

	var orientation: Bool {
		get {
			return UIDevice.current.orientation == .portrait ? true : false
		}
	}
	
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
		prevResultsTableView.backgroundColor = .clear
	}
	
	//MARK:- Methods
	
	func configure() {
		setUpViews()
	}
	
	func toggleBlurView(_ show: Bool) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
			self.blurView.alpha = show ? 1.0 : 0.0
		}, completion: nil)
	}
	
	func moveSearchBar(searching: Bool) {
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
			if self.orientation {
				//portrait
				self.searchStackViewTop?.constant = searching ? 100 : 200
			}
			if !self.orientation {
				//landscape
				self.titleLabel.isHidden = searching ? true : false
				self.searchStackViewTop?.constant = searching ? 20 : 90
			}
		}, completion: nil)
	}
}

//View layer setups
extension SearchView {
	
	///Set up all view in view
	func setUpViews() {
		//add to view
		[backgroundGradientContainerView].forEach({addSubview($0)})
		//add to container view
		[titleLabel, searchField, blurView, prevResultsTableView, searchGroupStackView].forEach({backgroundGradientContainerView.addSubview($0)})
		setupBackground()
		setUpTitle()
		setUpSearchField()
		setUpBlurView()
		setupTableView()
		setUpStackView()
	}
	
	private func setupBackground() {
		backgroundGradientContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
	}
	
	private func setUpTitle() {
		
		titleLabelTop = titleLabel.topAnchor.constraint(equalTo: backgroundGradientContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		
		titleLabelTrailing = titleLabel.trailingAnchor.constraint(equalTo: backgroundGradientContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		
		titleLabelLeading = titleLabel.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: backgroundGradientContainerView.leadingAnchor, constant: 35)
		
		titleLabel.heightAnchor.constraint(equalToConstant: 60)
		
		NSLayoutConstraint.activate([
			titleLabelLeading!,
			titleLabelTrailing!, titleLabelTop!
			])
	}
	
	private func setUpSearchField() {
		
		NSLayoutConstraint.activate([
			searchField.heightAnchor.constraint(equalToConstant: 65),
			searchField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 0)
			])
	}
	
	private func setUpBlurView() {
		blurView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
		blurView.alpha = 0.0
	}
	
	func setupTableView() {
		prevTableViewHeight = 	prevResultsTableView.heightAnchor.constraint(equalToConstant: 100)
		NSLayoutConstraint.activate([
			prevTableViewHeight!,
			prevResultsTableView.widthAnchor.constraint(equalTo: searchField.widthAnchor)
			])
	}
	
	func setUpStackView() {
		searchGroupStackView.addArrangedSubview(searchField)
		searchGroupStackView.addArrangedSubview(prevResultsTableView)
		
		searchStackViewTop = searchGroupStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 200)
		
		searchStackViewTrailing = searchGroupStackView.trailingAnchor.constraint(equalTo: backgroundGradientContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		
		searchStackViewLeading = searchGroupStackView.leadingAnchor.constraint(equalTo: backgroundGradientContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		
		
		searchStackViewTop?.isActive = true
		searchStackViewTrailing?.isActive = true
		searchStackViewLeading?.isActive = true
		
		
	}
	
}

extension SearchView {
	
	func landscape() {
		
		let stack = searchGroupStackView
		let title = titleLabel
		let container = backgroundGradientContainerView
		
		searchStackViewTop?.isActive = false
		searchStackViewTrailing?.isActive = false
		searchStackViewLeading?.isActive = false
		
		titleLabelTop?.isActive = false
		titleLabelTrailing?.isActive = false
		titleLabelLeading?.isActive = false
		
		searchStackViewTop = stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 90)
		searchStackViewTrailing = stack.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		
		titleLabelTop = title.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 100)
		titleLabelLeading = title.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		titleLabelTrailing = title.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -35)
		
		searchStackViewTop?.isActive = true
		searchStackViewTrailing?.isActive = true
		
		titleLabelTop?.isActive = true
		titleLabelTrailing?.isActive = true
		titleLabelLeading?.isActive = true
		
	}
	
	func portrait() {
		searchStackViewTop?.isActive = false
		searchStackViewTrailing?.isActive = false
		
		titleLabelTop?.isActive = false
		titleLabelTrailing?.isActive = false
		titleLabelLeading?.isActive = false
		
		setUpTitle()
		setUpStackView()
	}
	
}

