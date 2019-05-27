//
//  SavedResultsTableViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol SavedResultsSelectionDelegate: class {
	func didSelectMovie(_ movie: Movie)
}

///Saved results tableview delegate. This is used to display any saved content

class SavedResultsTableViewDelegate: NSObject, DataHandlerProtocol, UITableViewDelegate {
	
	
	var resultsHandler: ResultsDataHandler?
	
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
	
	weak var delegate: SavedResultsSelectionDelegate?
	
}

extension SavedResultsTableViewDelegate: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let data = resultsData else {
			return 0
		}
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.savedResultsCell.identity, for: indexPath) as! SavedMoviesTableViewCell
		
		guard let results = resultsData as? [Movie] else {return UITableViewCell()}
		
		cell.titleLabel.text = results[indexPath.row].movieTitle
		
		return cell
	}
}

extension SavedResultsTableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let results = resultsData as? [Movie] else {return}
		delegate?.didSelectMovie(results[indexPath.row])
	}
}
