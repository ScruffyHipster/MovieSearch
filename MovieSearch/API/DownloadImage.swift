//
//  DownloadImafe.swift
//  MovieSearch
//

import UIKit

protocol ImageCacheProtocol where Self: CustomImageView {
    var imageCache: Cache<String, UIImage> {get}
}


class CustomImageView: UIImageView, ImageCacheProtocol {
    var imageCache: Cache<String, UIImage> {
        return Cache<String, UIImage>()
    }
	var imageUrl: String?
	var downloadTask: URLSessionDownloadTask?
	
	/// Will download and resize image according to its image view bounds.
	///
	/// - Parameter urlString: Url from where the image is downloaded
	/// - Returns: A url session task. This runs in the class scope to all other functions to ammend the session if required.
	func downloadImage(from urlString: String) -> URLSessionDownloadTask? {
		guard let url = URL(string: urlString) else {return nil}
		//Check if image is in cache and download if not.
		if let imageFromCache = imageCache[urlString] {
			DispatchQueue.main.async {
                self.image = resizeImage(image: imageFromCache, for: self.frame.size)
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
                        self?.imageCache.insert(image, forKey: urlString)
					}
				}
			}
			downloadTask?.resume()
		}
		return downloadTask
	}

}
