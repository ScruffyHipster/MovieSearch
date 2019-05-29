//
//  ShadowImageView.swift
//  MovieSearch
//
//  Created by Tom Murray on 21/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class ScaleImageView: UIView {
	
	// for image caching
	var url: URL?
	
	var image: UIImage? {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override func draw(_ rect: CGRect) {
//		guard let image = self.image else { return }
//		// grab ratios and rect size
//		let imageRatio = image.size.width / image.size.height
//		let currentAspectRatio = self.bounds.width / self.bounds.height
//		var renderSize = self.bounds.size
//		// if its wider/ taller we need to shrink it
//		if imageRatio < currentAspectRatio {
//			renderSize.width = self.bounds.height * imageRatio
//		} else {
//			renderSize.height = self.bounds.width / imageRatio
//		}
//		//adjust the frame then draw in
//		let renderFrame = CGRect(x: 0, y: (self.bounds.height - renderSize.height) / 2, width: renderSize.width, height: renderSize.height)
		

//		image.draw(in: resizedImage)
	}


}
