//
//  DownloadImafe.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

//Creates a cache to store images in.

var imageCache = NSCache<NSString, UIImage>()
var savedImageCache = NSCache<NSString, UIImage>()


extension UIImageView {
	func downloadImage(from urlString: String, closure: @escaping (Bool) -> ()) {
		guard let url = URL(string: urlString) else {return}
		//Check if image is in cache and download if not.
		guard let imageFromCache = imageCache.object(forKey: urlString as NSString) else {
			URLSession.shared.downloadTask(with: url) { [weak self] (url, response, error) in
				guard error == nil else {
					print("Error occured \(String(describing: error))")
					return
				}
				guard let url = url else {return}
				do {
					let data = try? Data(contentsOf: url)
					if let data = data, let image = UIImage(data: data) {
						DispatchQueue.main.async {
							imageCache.setObject(image, forKey: urlString as NSString)
							if let weakSelf = self {
								weakSelf.image = image
							}
						}
					}
					closure(true)
				}
			}
			.resume()
			return
		}
		self.image = imageFromCache
	}
}
