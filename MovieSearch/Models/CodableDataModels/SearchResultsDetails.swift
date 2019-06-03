//
//  SearchResultsDetails.swift
//  MovieSearch
//

import Foundation

struct InitialSearchResultDetails: Codable {
	let search: [SearchResults]
	let totalResults, response: String
	
	enum CodingKeys: String, CodingKey {
		case search = "Search"
		case totalResults
		case response = "Response"
	}
}

struct SearchResults: Codable {
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
