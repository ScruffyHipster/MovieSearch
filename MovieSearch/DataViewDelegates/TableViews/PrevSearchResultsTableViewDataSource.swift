//
//  RecentSearchResultsTableViewDelegate.swift
//  MovieSearch
//

import Foundation
import UIKit

///Datasource and delegate for the previous search results tableview
class PrevSearchResultsTableViewDataSource: NSObject, DataHandlerProtocol, UITableViewDelegate {
	//MARK:- Properties
	var resultsHandler: ResultsDataHandler?
	///The array in which the tableView will populate itself
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
}

extension PrevSearchResultsTableViewDataSource: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let data = resultsData else {return 0}
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.prevResultsCell.identity, for: indexPath) as! PrevResultTableViewCell
		cell.titleLabel.text = resultsData?[indexPath.row] as? String
		return cell
	}
}
