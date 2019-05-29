//
//  ResultsErrorView.swift
//  MovieSearch
//
//  Created by Tom Murray on 29/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class ResultsErrorView: UIView {
	
	var backgroundContainerView: GradientContainerView = {
		let view = GradientContainerView(colorOne: nil, colorTwo: nil)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var noResultsLabel: UILabel = {
		let label = UILabel()
		label.text = "No Results"
		label.font = UsableFonts.titleFont
		label.textColor = UIColor.white
		label.alpha = 0.0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		[backgroundContainerView, noResultsLabel].forEach({addSubview($0)})
		
		backgroundContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
		
		noResultsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
		noResultsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
	}
	
}
