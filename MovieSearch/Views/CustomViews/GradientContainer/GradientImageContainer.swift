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
	
	var gradientView: GradientContainerView = {
		var gradient = GradientContainerView(colorOne: GradientColors.black.rgb.cgColor, colorTwo: GradientColors.clear.rgb.cgColor)
		return gradient
	}()
	
	private func setupImageView() {
		
		addSubview(mainImage)
		addSubview(gradientView)
		
		gradientView.anchor(top: topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor)
		
		mainImage.anchor(top: topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor)
	}
	
}
