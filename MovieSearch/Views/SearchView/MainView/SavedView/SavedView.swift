//
//  SavedView.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class SavedView: UIView {

	
	//MARK:- Properties
	
	var backgroundContainerView: GradientContainerView = {
		var view = GradientContainerView(frame: .zero)
		return view
	}()
	
	var mainTitle: UILabel = {
		var title = UILabel(frame: .zero)
		title.font = UsableFonts.titleFont
		title.text = "Saved Movies"
		title.textAlignment = .left
		title.textColor = UsableColours.searchText
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var savedMoviesTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.register(SavedMoviesTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier.savedResultsCell.identity)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.isScrollEnabled = false
		tableView.separatorColor = .white
		return tableView
	}()
	
	var savedResultsTableViewHeight: NSLayoutConstraint?
	
	//Variables for rotation use
	var savedResultsTableViewTop: NSLayoutConstraint?
	var savedResultsTableViewTrailing: NSLayoutConstraint?
	var savedResultsTableviewLeading: NSLayoutConstraint?
	
	var mainTitleTop: NSLayoutConstraint?
	var mainTitleLeading: NSLayoutConstraint?
	var mainTitletrailing: NSLayoutConstraint?
	
	var savedTableViewDelegate: SavedResultsTableViewDelegate? {
		didSet {
			self.savedMoviesTableView.delegate = self.savedTableViewDelegate
			self.savedMoviesTableView.dataSource = self.savedTableViewDelegate
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		savedMoviesTableView.backgroundColor = .clear
	}
	
	//MARK:- Methods
	func setUpViews() {
		[backgroundContainerView].forEach({addSubview($0)})
		[mainTitle, savedMoviesTableView].forEach({addSubview($0)})
		setUpContainerView()
		setUpTitleView()
		setUpSavedResultsTableView()
	}
	

}

//MARK:- Setup views
extension SavedView {
	
	private func setUpContainerView() {
		backgroundContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
	}
	
	private func setUpTitleView() {
		
		mainTitleTop = mainTitle.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		
		mainTitleLeading = mainTitle.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		
		mainTitletrailing = mainTitle.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		
		NSLayoutConstraint.activate([
			mainTitle.heightAnchor.constraint(equalToConstant: 60),
			mainTitletrailing!,
			mainTitleLeading!,
			mainTitleTop!
			])
	}
	
	private func setUpSavedResultsTableView() {
		
		savedResultsTableViewHeight = savedMoviesTableView.heightAnchor.constraint(equalToConstant: savedMoviesTableView.contentSize.height)
		
		savedResultsTableViewTop = savedMoviesTableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 106)
		
		savedResultsTableviewLeading = savedMoviesTableView.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		
		savedResultsTableViewTrailing = savedMoviesTableView.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		
		NSLayoutConstraint.activate([
			savedResultsTableviewLeading!,
			savedResultsTableViewTop!,
			savedResultsTableViewHeight!,
			savedResultsTableViewTrailing!
			])
		
	}
	
	
}



//MARK:- Orientation layout
extension SavedView {
	
	func portrait() {
		savedResultsTableViewTop?.isActive = false
		savedResultsTableViewTrailing?.isActive = false
		savedResultsTableviewLeading?.isActive = false
		
		mainTitleTop?.isActive = false
		mainTitleLeading?.isActive = false
		
		setUpTitleView()
		setUpSavedResultsTableView()
	}
	
	func landscape() {
		savedResultsTableViewTop?.isActive = false
		savedResultsTableViewTrailing?.isActive = false
		savedResultsTableviewLeading?.isActive = false
		
		mainTitleTop?.isActive = false
		mainTitleLeading?.isActive = false
		mainTitletrailing?.isActive = false
		
		savedResultsTableViewTop = savedMoviesTableView.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		savedResultsTableViewTrailing = savedMoviesTableView.trailingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -35)
		savedResultsTableviewLeading = savedMoviesTableView.leadingAnchor.constraint(equalTo: mainTitle.trailingAnchor, constant: 35)
		
		mainTitleTop = mainTitle.topAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.topAnchor, constant: 100)
		mainTitleLeading = mainTitle.leadingAnchor.constraint(equalTo: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 35)
		
		NSLayoutConstraint.activate([
			
			savedResultsTableViewTop!,
			savedResultsTableViewTrailing!,
			savedResultsTableviewLeading!,
			mainTitleTop!,
			mainTitleLeading!
			])
		
	}
	
}


