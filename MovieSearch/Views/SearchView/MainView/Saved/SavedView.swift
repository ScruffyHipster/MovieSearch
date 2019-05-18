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
		return title
	}()
	
	var savedMoviesTableView: UITableView = {
		var tableView = UITableView(frame: .zero, style: .plain)
		tableView.backgroundColor = UIColor.clear
		tableView.register(SavedMoviesTableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier.savedResultsCell.identity)
		tableView.isScrollEnabled = false
		tableView.separatorColor = .white
		return tableView
	}()
	
	var savedResultsTableViewHeight: NSLayoutConstraint?
	
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


extension SavedView {
	
	private func setUpContainerView() {
		backgroundContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
	}
	
	private func setUpTitleView() {
		mainTitle.anchor(top: backgroundContainerView.safeAreaLayoutGuide.topAnchor, trailing: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 100, left: 35, bottom: 0, right: -35), size: .init(width: 0, height: 60))
	}
	
	private func setUpSavedResultsTableView() {
		
		savedResultsTableViewHeight = savedMoviesTableView.heightAnchor.constraint(equalToConstant: 100)
		savedResultsTableViewHeight?.isActive = true
		
		savedMoviesTableView.anchor(top: mainTitle.bottomAnchor, trailing: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 106, left: 35, bottom: 0, right: -35))
	}
	
	
}
