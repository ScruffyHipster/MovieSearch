//
//  SearchView.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///View for the main search tab bar view
class SearchView: UIView {
	
	//MARK:- Properties
	
	lazy var gradientLayer: CAGradientLayer = {
		var gradient = CAGradientLayer()
		gradient.frame = bounds
		gradient.colors = [GradientColors.blue.rgb.cgColor, GradientColors.green.rgb.cgColor]
		return gradient
	}()
	
	lazy var titleLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.text = "Movie Search"
		label.textAlignment = .left
		label.font = UsableFonts.titleFont
		label.textColor = UIColor.white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var searchField: SearchField = {
		return SearchField(frame: .zero)
	}()

	//MARK:- Init methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Methods
	
	func configure() {
		setupBackground()
		setUpTitle()
		setUpSearchField()
	}
	

}

extension SearchView {
	
	func setupBackground() {
		layer.addSublayer(gradientLayer)
	}
	
	func setUpTitle() {
		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
			titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
			titleLabel.heightAnchor.constraint(equalToConstant: 60)
			])
	}
	
	func setUpSearchField() {
		addSubview(searchField)
		NSLayoutConstraint.activate([
			searchField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 237),
			searchField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -34),
			searchField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 34),
			searchField.heightAnchor.constraint(equalToConstant: 60)
			])
	}
	
}
