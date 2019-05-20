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

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	private func setup() {
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
		guard let gradientLayer = self.layer as? CAGradientLayer else {return}
		gradientLayer.colors = [GradientColors.blue.rgb.cgColor, GradientColors.green.rgb.cgColor]
		gradientLayer.frame = self.bounds
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
}
