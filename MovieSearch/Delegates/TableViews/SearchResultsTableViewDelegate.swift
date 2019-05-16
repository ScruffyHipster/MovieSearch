//
//  SearchResultsTableViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 16/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Recent search results tableview. This is used to display the recent results under the UISearch field.
class RecentSearchResultsTableViewDelegate: NSObject, UITableViewDelegate {
	
}

extension RecentSearchResultsTableViewDelegate: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		return cell
	}
	
}
