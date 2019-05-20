//
//  SearchResultsDetails.swift
//  MovieSearch
//
//  Created by Tom Murray on 19/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation

import Foundation


struct SearchResultDetails: Codable {
	let search: [Search]
	let totalResults, response: String
	
	enum CodingKeys: String, CodingKey {
		case search = "Search"
		case totalResults
		case response = "Response"
	}
}

struct Search: Codable {
	let title, year, imdbID: String
	let type: TypeEnum
	let poster: String
	
	enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case imdbID
		case type = "Type"
		case poster = "Poster"
	}
}

enum TypeEnum: String, Codable {
	case movie = "movie"
	case series = "series"
	case game = "game"
	case episode = "episode"
}
