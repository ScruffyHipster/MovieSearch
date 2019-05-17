//
//  RecentSearchResultsTableViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 16/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Recent search results tableview. This is used to display the recent results under the UISearch field.
class PrevSearchResultsTableViewDelegate: NSObject, UITableViewDelegate {
	
	var resultsHandler: ResultsDataHandler?
	
	///The array in which the tableView will populate itself
	var resultData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
	
}

extension PrevSearchResultsTableViewDelegate: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let data = resultData else {return 0}
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.prevResultsCell.identity, for: indexPath) as! PrevResultTableViewCell
		cell.titleLabel.text = resultData?[indexPath.row] as? String
		return cell
	}
}
