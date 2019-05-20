//
//  HttpAPI.swift
//  MovieSearch
//
//  Created by Tom Murray on 19/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation


class HttpAPI {
	
	var dataTask: URLSessionDataTask?
	var apiKey = "apikey=592d6c41"
	var request: URLRequest?
	
	lazy var decoder: JSONDecoder = {
		return JSONDecoder()
	}()
	
	func createUrl(searchParam: SearchParam, searchTerm: String) -> URLRequest {
		if !searchTerm.isEmpty {
			let term = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+").lowercased()
			request = URLRequest(url: URL(string: "https://www.omdbapi.com/?\(searchParam.term)=\(term)&\(apiKey)")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 300)
		}
		return request!
	}
	
	func makeRequest<T: Codable>(url request: URLRequest, for dataStructure: T.Type, closure: @escaping (Bool, [Any]) -> (Void)) {
		var success = false
		dataTask?.cancel()
		dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
			print(request)
			guard let response = response as? HTTPURLResponse else {
				success = false
				closure(success, [])
				return
			}
			if self.checkResonse(responseCode: response.statusCode) {
				guard let jsonData = data else {return}
				do {
					let resultData = try self.decoder.decode(dataStructure.self, from: jsonData)
					success = true
					print(resultData)
					closure(success, [resultData] as [AnyObject])
				} catch {
					success = false
					print(error)
					closure(success, [])
				}
			} else {
				success = false
				closure(success, [])
			}
		})
		dataTask?.resume()
	}
	
	func cancelTask() {
		if dataTask != nil {
			dataTask?.cancel()
		}
	}
	
	private func checkResonse(responseCode: Int) -> Bool {
		var result = false
		switch(responseCode) {
		case 200, 201:
			result = true
		case 204, 400, 401, 403, 404, 405, 408, 409, 500, 501, 503:
			result = false
		default:
			break
		}
		return result
	}
	
}
