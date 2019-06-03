//
//  PrevResultTableViewCell.swift
//  MovieSearch
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
}


extension PrevResultTableViewCell {
	//MARK:- Methods
	func configure() {
		setUpCell()
		setUpText()
	}
	
	private func setUpCell() {
		accessoryType = .disclosureIndicator
		selectionStyle = .none
		self.backgroundColor = .clear
	}
	
	private func setUpText() {
		addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			titleLabel.heightAnchor.constraint(equalToConstant: 50)
			])
	}
}
