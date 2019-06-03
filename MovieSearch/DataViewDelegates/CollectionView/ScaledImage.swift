//
//  ScaledImage.swift
//  MovieSearch
//
//  Created by Tom Murray on 22/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class ScaledImage: UIView {

	var image: UIImage? {
		didSet {
			resize()
		}
	}
	
	var shadowView: UIView = {
		let view = UIView(frame: .zero)
		return view
	}()
	
	var imageView = UIImageView = {
		var imageView = UIImageView(frame: .zero)
		guard let image = image else {return}
		
		imageView.image = resizeImage(image: <#T##UIImage#>, for: <#T##CGSize#>)
	}()
	
	private func resize() {
		
		resizeImage(image: image, for: self.bounds.size)
	}
	

}
