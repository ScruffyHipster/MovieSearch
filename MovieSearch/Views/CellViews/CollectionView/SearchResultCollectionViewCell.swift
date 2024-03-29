//
//  SearchResultCollectionViewCell.swift
//  MovieSearch
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
	//MARK:- Properties
	var orientation: Bool {
		return UIDevice.current.orientation.isPortrait ? true : false
	}
	var downloadTask: URLSessionDownloadTask?
	
	var titleLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.textColor = UsableColours.searchText
		label.font = UsableFonts.searchResultFont
		label.textAlignment = .left
		label.numberOfLines = 2
		label.adjustsFontSizeToFitWidth = true
		label.allowsDefaultTighteningForTruncation = true
		label.text = "placeholder"
		return label
	}()
	
	var mainImage: CustomImageView = {
		var imageView = CustomImageView(frame: .zero)
		imageView.contentMode = UIView.ContentMode.scaleAspectFill
		imageView.image = #imageLiteral(resourceName: "posterPlaceholder")
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	
	var contentStack: UIStackView = {
		var stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = true
		stack.alignment = UIStackView.Alignment.center
		stack.axis = .vertical
		stack.spacing = 6
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackView.Distribution.fillProportionally
		return stack
	}()
	
	//MARK:- Init methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		downloadTask?.cancel()
		downloadTask = nil
	}
}

extension SearchResultCollectionViewCell {
	//MARK:- Methods
	func configure() {
		setUpStack()
		backgroundColor = .clear
	}
	
	func configureCell(with results: SearchResults) {
		titleLabel.text = results.title
		downloadTask = mainImage.downloadImage(from: results.poster)
	}
	
	private func setUpStack() {
		[mainImage, titleLabel, contentStack].forEach({addSubview($0)})
		arrangeStack()
	}

	private func arrangeStack() {
		contentStack.addArrangedSubview(mainImage)
		contentStack.addArrangedSubview(titleLabel)
		contentStack.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
	}
}
