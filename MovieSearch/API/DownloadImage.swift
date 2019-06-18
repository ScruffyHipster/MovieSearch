//
//  DownloadImafe.swift
//  MovieSearch
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
	var imageUrl: String?
	var downloadTask: URLSessionDownloadTask?
	
	///Will download and resize image according to its image view bounds.
	func downloadImage(from urlString: String) -> URLSessionDownloadTask? {
		imageUrl = urlString
		guard let url = URL(string: urlString) else {return nil}
		//Check if image is in cache and download if not.
		if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
			DispatchQueue.main.async {
				if self.imageUrl == urlString {
					self.image = resizeImage(image: imageFromCache, for: self.frame.size)
				}
			}
		} else {
			downloadTask = URLSession.shared.downloadTask(with: url) { [weak self] (url, response, error) in
				guard error == nil else {return}
				guard let url = url else {return}
				do {
					let data = try? Data(contentsOf: url)
					if let data = data, let image = UIImage(data: data) {
						if let weakSelf = self {
							DispatchQueue.main.async {
								weakSelf.image = resizeImage(image: image, for: (self?.frame.size)!)
							}
						}
						print("image is \(image), from url \(url)")
						imageCache.setObject(image, forKey: urlString as NSString)
					}
				}
			}
			downloadTask?.resume()
		}
		return downloadTask
	}
}
