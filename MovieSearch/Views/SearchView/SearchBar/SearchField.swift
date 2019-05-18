//
//  SearchField.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

///Custom reusable search field
class SearchField: UITextField {
	
	//MARK:- Properties
	var bottomLine: UIView = {
		let view = UIView(frame: .zero)
		view.backgroundColor = UsableColours.lineColor
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var placeHolderLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Search"
		label.font = UsableFonts.searchFont
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 40
		label.textColor = UsableColours.searchPlaceholder
		label.textAlignment = .left
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
	
}

extension SearchField {
	
	private func configure() {
		setUpStyle()
		setupBottomLine()
		setUpPlaceHolderText()
	}
	
	private func setUpStyle() {
		translatesAutoresizingMaskIntoConstraints = false
		textAlignment = .left
		tintColor = UsableColours.white
		font = UsableFonts.searchFont
		textColor = UsableColours.white
		clearButtonMode = .whileEditing
		keyboardType = .default
	}
	
	private func setupBottomLine() {
		addSubview(bottomLine)
		NSLayoutConstraint.activate([
			bottomLine.heightAnchor.constraint(equalToConstant: 1),
			bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor),
			bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor),
			bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor)
			])
	}
	
	private func setUpPlaceHolderText() {
		addSubview(placeHolderLabel)
		NSLayoutConstraint.activate([
			placeHolderLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
			placeHolderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1),
			placeHolderLabel.heightAnchor.constraint(equalToConstant: 50)
			])
	}
	
}

