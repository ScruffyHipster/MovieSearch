//
//  GradientContainerView.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///Gradient layer view
class GradientContainerView: UIView {
	
	lazy var gradientLayer: CAGradientLayer = {
		var gradient = CAGradientLayer()
		gradient.colors = [GradientColors.blue.rgb.cgColor, GradientColors.green.rgb.cgColor]
		gradient.frame = self.bounds
		return gradient
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.addSublayer(gradientLayer)
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		gradientLayer.frame = bounds
	}

}
