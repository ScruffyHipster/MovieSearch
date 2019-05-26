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
	case black
	case clear
	
	var rgb: UIColor {
		switch self {
		case .blue:
			return UIColor(red: 11 / 255, green: 49 / 255, blue: 208 / 255, alpha: 0.6)
		case .green:
			return UIColor(red: 96 / 255, green: 234 / 255, blue: 234 / 255, alpha: 1.0)
		case .black:
			return UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0)
		case .clear:
			return UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.0)
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

enum CollectionViewCellIdentifiers {
	case searchResultCVCell
	
	var identity: String {
		switch self {
		case .searchResultCVCell:
			return "SearchResultCVCell"
		}
	}
}

///used to ammend the url request for OMDB
enum SearchParam {
	
	case search
	case id
	
	var term: String {
		switch self {
		case .search:
			return "s"
		case .id:
			return "i"
		}
	}
}

enum Orientation {
	case portrait
	case landscape
}
