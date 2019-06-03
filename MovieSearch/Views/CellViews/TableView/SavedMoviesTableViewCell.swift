//
//  SavedMoviesTableViewCell.swift
//  MovieSearch
//

import UIKit

class SavedMoviesTableViewCell: UITableViewCell {
	//MARK:- Properties
	var titleLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.textColor = .white
		label.font = UsableFonts.savedResultsFont
		label.textAlignment = .left
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		return label
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

extension SavedMoviesTableViewCell {
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
		titleLabel.anchor(top: nil, trailing: nil, bottom: nil, leading: leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: bounds.size.width, height: 50))
	}
}
