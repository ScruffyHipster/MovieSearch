//
//  HttpAPI.swift
//  MovieSearch
//
//  Created by Tom Murray on 19/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation


class HttpAPI: NSObject {
	
	var dataTask: URLSessionDataTask?
	
	var apiKey = "apikey=592d6c41"
	
	var request: URLRequest?
	
	var activeDownload: [URL: URLSessionDownloadTask] = [:]
	
	lazy var session: URLSession = {
		var sessionConfig  = URLSessionConfiguration.default
		return URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
	}()
	
	lazy var decoder: JSONDecoder = {
		return JSONDecoder()
	}()
	
	func createUrl(searchParam: SearchParam, searchTerm: String) -> URLRequest {
		if !searchTerm.isEmpty {
			let term = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+").lowercased()
			request = URLRequest(url: URL(string: "https://www.omdbapi.com/?\(searchParam.term)=\(term)&\(apiKey)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
		}
		return request!
	}
	
	func makeRequest<T: Codable>(url request: URLRequest, for dataStructure: T.Type, closure: @escaping (Bool, T?, Error?) -> (Void)) {
		var success = false
		dataTask?.cancel()
		dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
			guard let response = response as? HTTPURLResponse else {
				success = false
				closure(success, nil, error)
				return
			}
			if self.checkResonse(responseCode: response.statusCode) {
				guard let jsonData = data else {return}
				do {
					let resultData = try self.decoder.decode(dataStructure.self, from: jsonData)
					success = true
					closure(success, resultData, nil)
				} catch {
					success = false
					print(error)
					closure(success, nil, error)
				}
			} else {
				success = false
				closure(success, nil, error)
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

extension HttpAPI: URLSessionDownloadDelegate {
	
	///Downloads and saves the image to locally to disk using the image url
	func downloadImage(_ imageUrl: String) {
		let imageUrl = URL(string: imageUrl)
		if let url = imageUrl {
			let download = session.downloadTask(with: url)
			download.resume()
			activeDownload[url] = download
		}
	}
	
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		guard let sourceUrl = downloadTask.originalRequest?.url else {return}
		//remove the download url from the dictionary once download is complete
		activeDownload[sourceUrl] = nil
		
		let fileManager = FileManager.default
		//create a url and move the item to it.
		let destinationUrl = fileManager.localFileUrl(for: sourceUrl)
		try? fileManager.removeItem(at: destinationUrl)
		do {
			try fileManager.copyItem(at: location, to: destinationUrl)
		} catch {
		}
	}
	
}
