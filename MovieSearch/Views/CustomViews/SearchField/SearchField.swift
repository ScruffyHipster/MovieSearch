//
//  SearchField.swift
//  MovieSearch
//

import UIKit

///Custom search field 
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
	
	lazy var loadingIndicator: UIActivityIndicatorView = {
		var indicator = UIActivityIndicatorView()
		indicator.style = UIActivityIndicatorView.Style.whiteLarge
		indicator.startAnimating()
		indicator.alpha = 0.0
		return indicator
	}()

	//MARK:- Init methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SearchField {
	//MARK:- Methods
	private func configure() {
		setUpStyle()
		setupBottomLine()
		setUpPlaceHolderText()
		setUploadingIndicator()
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
	
	private func setUploadingIndicator() {
		addSubview(loadingIndicator)
		loadingIndicator.anchor(top: topAnchor, trailing: trailingAnchor, bottom: nil, leading: nil, padding: .init(top: 30, left: 0, bottom: 0, right: -10), size: .init(width: 10, height: 10))
	}
	
}

