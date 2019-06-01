//
//  SavedResultsTableViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Savedresults tableview delegate which allows communication with the coordinator
protocol SavedResultsSelectionDelegate: class {
	func didSelectMovie(_ movie: Movie)
	func deleteMovie(_ movie: Movie)
}

///Datasource and delegate for the saved results tableview
class SavedResultsTableViewDelegate: NSObject, DataHandlerProtocol, UITableViewDelegate {
	
	
	var resultsHandler: ResultsDataHandler?
	
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		} set {
			resultsHandler?.resultsData = newValue
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
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		switch editingStyle {
		case .delete:
			guard let results = resultsData as? [Movie] else {return}
			resultsData?.remove(at: indexPath.row)
			
			tableView.performBatchUpdates({
				tableView.deleteRows(at: [indexPath], with: .fade)
			}, completion: { _ in
				self.delegate?.deleteMovie(results[indexPath.row])
			})
			break
		default:
			break
		}
	}
}
