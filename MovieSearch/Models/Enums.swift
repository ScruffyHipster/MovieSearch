//
//  Enums.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit


enum GradientColors {
	case blue
	case green
	
	var rgb: UIColor {
		switch self {
		case .blue:
			return UIColor(red: 11 / 255, green: 49 / 255, blue: 208 / 255, alpha: 0.6)
		case .green:
			return UIColor(red: 96 / 255, green: 234 / 255, blue: 234 / 255, alpha: 1.0)
		}
	}
}

///Used to add readability to some animations
enum Direction {
	case up
	case down
}

enum TableViewCellIdentifier {
	case prevResultsCell
	case savedResultsCell
	var identity: String {
		switch self {
		case .prevResultsCell:
			return "PrevResultsCell"
		case .savedResultsCell:
			return "SavedResultsCell"
		}
	}
}

///used to ammend the url request for OMDB
enum SearchParam {
	case title
	case search
	
	var term: String {
		switch self {
		case .search:
			return "s"
		case .title:
			return "t"
		}
	}
}
