//
//  SearchResultCollectionViewCell.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit



class SearchResultCollectionViewCell: UICollectionViewCell {
	
	
	//MARK:- Properties
	
	
	var titleLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.textColor = UsableColours.searchText
		label.font = UsableFonts.searchResultFont
		label.textAlignment = .left
//		label.allowsDefaultTighteningForTruncation = true
		label.minimumScaleFactor = 0.6
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	
	var mainImage: UIImageView = {
		var imageView = UIImageView(frame: .zero)
		imageView.contentMode = UIView.ContentMode.scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	
	var starImage: UIImageView = {
		let image = UIImageView(frame: .zero)
		image.image = UIImage(named: "ratingGoldStar")
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		return image
	}()
	
	var ratingText: UILabel = {
		var rating = UILabel(frame: .zero)
		rating.font = UsableFonts.ratingFont
		rating.textColor = .white
		rating.minimumScaleFactor = 0.2
		rating.textAlignment = .left
		return rating
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
		setUpCell()
		backgroundColor = .clear
	}
	
}

extension SearchResultCollectionViewCell {
	
	func configureImage(image: UIImage) {
		DispatchQueue.main.async {
			self.mainImage.image = resizeImage(image: image, for: self.mainImage.bounds.size)
		}
		
	}
	
	private func setUpCell() {
		

		[mainImage, titleLabel, starImage, ratingText].forEach({addSubview($0)})

		setUpPosterImage()
		setUpName()
		setUpRating()
		setUpText()
		
	}
	
	private func setUpPosterImage() {
		
		mainImage.translatesAutoresizingMaskIntoConstraints = false
		
		mainImage.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
		
		mainImage.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: titleLabel.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 20, left: 40, bottom: -20, right: -40))
		
	}
	
	private func setUpName() {
		
		titleLabel.anchor(top: nil, trailing: mainImage.trailingAnchor, bottom: nil, leading: mainImage.leadingAnchor)

		
	}
	
	private func setUpRating() {
		starImage.anchor(top: titleLabel.bottomAnchor, trailing: nil, bottom: bottomAnchor, leading: mainImage.leadingAnchor, padding: .init(top: 8, left: 0, bottom: -20, right: 0), size: .init(width: 14, height: 14))
	}

	private func setUpText() {
		ratingText.anchor(top: titleLabel.bottomAnchor, trailing: nil, bottom: bottomAnchor, leading: starImage.trailingAnchor, padding: .init(top: 6, left: 10, bottom: -20, right: 0))
	}
	

}
