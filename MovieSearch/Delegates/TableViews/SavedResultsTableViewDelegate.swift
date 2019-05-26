//
//  SavedResultsTableViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Saved results tableview delegate. This is used to display any saved content

class SavedResultsTableViewDelegate: NSObject, DataHandlerProtocol, UITableViewDelegate {
	
	
	var resultsHandler: ResultsDataHandler?
	
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
	
	
}

extension SavedResultsTableViewDelegate: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let data = resultsData else {
			return 4
		}
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.savedResultsCell.identity, for: indexPath) as! SavedMoviesTableViewCell
		cell.titleLabel.text = resultsData?[indexPath.row] as? String
		return cell
	}
	
	
}
