//
//  PrevSearchResultsTableView.swift
//  MovieSearch
//
//  Created by Tom Murray on 17/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///Tableview which shows the users previous search results if any.
class PrevSearchResultsTableView: UITableView {
	
	//MARK:- Init methods
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		configure()
	}
	
	func configure() {
		backgroundColor = .clear
		separatorStyle = .singleLine
		separatorColor = .white
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
