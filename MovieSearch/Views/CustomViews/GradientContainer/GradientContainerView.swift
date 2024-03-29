//
//  GradientContainerView.swift
//  MovieSearch
//

import UIKit

///View with a custom gradient overlay. Leave init at nil to produce standard app gradient. Add colours to customise.
class GradientContainerView: UIView {
	//MARK:- Properties
	var colourOne: CGColor?
	var colourTwo: CGColor?
	
	//MARK:- Init Methods
	init(colorOne: CGColor? = nil, colorTwo: CGColor? = nil) {
		super.init(frame: .zero)
		self.colourOne = colorOne
		self.colourTwo = colorTwo
		setup()
	}
	
	private func setup() {
		guard let colourOne = colourOne, let colourTwo = colourTwo else {
			autoresizingMask = [.flexibleWidth, .flexibleHeight]
			guard let gradientLayer = self.layer as? CAGradientLayer else {return}
			gradientLayer.colors = [GradientColors.blue.rgb.cgColor, GradientColors.green.rgb.cgColor]
			gradientLayer.frame = self.bounds
			return
		}
		guard let gradientLayer = self.layer as? CAGradientLayer else {return}
		gradientLayer.colors = [colourOne, colourTwo]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.26)
		gradientLayer.frame = self.bounds
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
}
