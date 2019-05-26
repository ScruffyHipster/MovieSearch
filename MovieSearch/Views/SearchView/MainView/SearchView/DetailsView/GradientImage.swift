//
//  GradientImage.swift
//  MovieSearch
//
//  Created by Tom Murray on 23/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///This view has a gradient which overlays the image allowing the top buttons to be seen on all image colours. Primarlily white on white.
class GradientImageContainer: UIView {

	//Init Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpGradient()
		setupImageView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//Properties
	var mainImage: CustomImageView = {
		var image = CustomImageView(frame: .zero)
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	//Methods
	private func setUpGradient() {
		guard let gradientLayer = self.layer as? CAGradientLayer else
		{return}
		gradientLayer.colors = [GradientColors.black.rgb.cgColor, GradientColors.clear.rgb.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.26)
		gradientLayer.frame = self.bounds
	}
	
	private func setupImageView() {
		insertSubview(mainImage, at: 0)
		mainImage.anchor(top: topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor)
	}
	
	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
	
	
}
