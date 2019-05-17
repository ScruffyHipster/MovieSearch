//
//  PrevResultTableViewCell.swift
//  MovieSearch
//
//  Created by Tom Murray on 17/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class PrevResultTableViewCell: UITableViewCell {
	
	//MARK:- Properties
	var titleLabel: UILabel = {
		var titleLabel = UILabel(frame: .zero)
		titleLabel.textColor = UsableColours.searchText
		titleLabel.font = UsableFonts.prevResultFont
		titleLabel.textAlignment = .left
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		return titleLabel
	}()

	//MARK:- Init methods
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
	}
	
	func configure() {
		setUpCell()
		setUpText()
	}
	
}

//MARK:- Setup Style
extension PrevResultTableViewCell {
	
	private func setUpCell() {
		accessoryType = .disclosureIndicator
		selectionStyle = .none
		self.backgroundColor = .clear
	}
	
	private func setUpText() {
		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			titleLabel.heightAnchor.constraint(equalToConstant: 50)
			])
	}
	
}
