//
//  DownloadImafe.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
	var imageUrl: String?
	
	///Will download and resize image according to its image view bounds.
	func downloadImage(from urlString: String) {
		imageUrl = urlString
		guard let url = URL(string: urlString) else {return}
		//Check if image is in cache and download if not.
		guard let imageFromCache = imageCache.object(forKey: urlString as NSString) else {
			URLSession.shared.downloadTask(with: url) { [weak self] (url, response, error) in
				guard error == nil else {
					return
				}
				guard let url = url else {return}
				do {
					let data = try? Data(contentsOf: url)
					if let data = data, let image = UIImage(data: data) {
						DispatchQueue.main.async {
							imageCache.setObject(image, forKey: urlString as NSString)
							if let weakSelf = self {
								weakSelf.image = resizeImage(image: image, for: (self?.frame.size)!)
							}
						}
					}
				}
			}
			.resume()
			return
		}
		DispatchQueue.main.async {
			if self.imageUrl == urlString {
				self.image = resizeImage(image: imageFromCache, for: self.frame.size)
				return
			}
		}
	}
}
