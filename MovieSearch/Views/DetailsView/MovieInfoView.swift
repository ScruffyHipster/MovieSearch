//
//  DetailsInfoView.swift
//  MovieSearch
//

import Foundation
import UIKit

///Container for the info details of the selected movie
class MovieInfoView: UIView {
	//MARK:- Init methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupStackViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Properties
	var ratingImageHeight: NSLayoutConstraint?
	var ratingImageWidth: NSLayoutConstraint?
	
	var mainTitle: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = UsableFonts.detailsTitleLabel
		label.textColor = .white
		label.textAlignment = .left
		label.numberOfLines = 2
		label.sizeToFit()
		label.adjustsFontSizeToFitWidth = true
		label.text = "Detective Pickachu"
		label.numberOfLines = 2
		return label
	}()
	
	var plotInfo: UITextView = {
		var textView = UITextView(frame: .zero)
		textView.font = UIFont(name: "Helvetica Neue", size: 12)
		textView.textAlignment = .left
		textView.text = "In a world where people collect Pokémon to do battle, a boy comes across an intelligent talking Pikachu who seeks to be a detective."
		textView.isEditable = true
		textView.textColor = .white
		textView.backgroundColor = .clear
		textView.isScrollEnabled = false
		return textView
	}()

	var seperatorLine: UIView = {
		var line = UIView(frame: .zero)
		line.backgroundColor = .white
		return line
	}()
	
	var directorLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = UsableFonts.detailsTextLabel
		label.textColor = .white
		label.allowsDefaultTighteningForTruncation = true
		label.numberOfLines = 2
		label.text = "Director: Some visionary)"
		return label
	}()
	
	var writersLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = UsableFonts.detailsTextLabel
		label.allowsDefaultTighteningForTruncation = true
		label.textColor = .white
		label.numberOfLines = 2
		label.text = "Writers: The real heros"
		return label
	}()
	
	var actorsLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = UsableFonts.detailsTextLabel
		label.textColor = .white
		label.allowsDefaultTighteningForTruncation = true
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.numberOfLines = 3
		label.text = "Actors: These guys"
		return label
	}()
	
	
	var ratingImage: UIImageView = {
		var image = UIImageView()
		image.image = #imageLiteral(resourceName: "ratingGoldStar")
		image.clipsToBounds = true
		return image
	}()
	
	var ratingLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = UsableFonts.ratingFont
		label.textColor = .white
		label.text = "10 / 10"
		return label
	}()
	
	var topInfoStackView: UIStackView = {
		var topStack = UIStackView(frame: .zero)
		topStack.alignment = .leading
		topStack.distribution = UIStackView.Distribution.fillProportionally
		topStack.axis = .vertical
		topStack.spacing = 10
		return topStack
	}()
	
	var bottomInfoStack: UIStackView = {
		var bottomStack = UIStackView(frame: .zero)
		bottomStack.alignment = UIStackView.Alignment.leading
		bottomStack.distribution = .fill
		bottomStack.axis = .vertical
		bottomStack.spacing = 10
		return bottomStack
	}()
	
	var ratingInfoStack: UIStackView = {
		var ratingStack = UIStackView(frame: .zero)
		ratingStack.alignment = UIStackView.Alignment.center
		ratingStack.axis = .horizontal
		ratingStack.spacing = 10
		ratingStack.distribution = UIStackView.Distribution.fillProportionally
		return ratingStack
	}()
	
}

extension MovieInfoView {
	//MARK:- Methods
	private func setupStackViews() {
		[topInfoStackView, bottomInfoStack, ratingInfoStack].forEach({addSubview($0)})
		setUpTopStack()
		setUpSeperatorLine()
		setUpBottomInfoStack()
		setUpRatingInfoStack()
	}
	
	private func setUpTopStack() {
		[mainTitle, plotInfo].forEach({topInfoStackView.addArrangedSubview($0)})
		topInfoStackView.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 2, left: 10, bottom: 0, right: 0))
	}
	
	private func setUpSeperatorLine() {
		[seperatorLine].forEach({addSubview($0)})
		
		seperatorLine.anchor(top: topInfoStackView.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: -10), size: .init(width: 0, height: 1))

	}
	
	private func setUpBottomInfoStack() {
		[directorLabel, writersLabel, actorsLabel].forEach({bottomInfoStack.addArrangedSubview($0)})
		bottomInfoStack.anchor(top: seperatorLine.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 22, left: 10, bottom: 0, right: 0))
	}
	
	private func setUpRatingInfoStack() {
		[ratingImage,ratingLabel].forEach({ratingInfoStack.addArrangedSubview($0)})
		ratingImageHeight = ratingImage.heightAnchor.constraint(equalToConstant: 23)
		ratingImageWidth = ratingImage.widthAnchor.constraint(equalToConstant: 23)
		[ratingImageWidth, ratingImageHeight].forEach({$0?.isActive = true})
		ratingInfoStack.anchor(top: bottomInfoStack.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: -10))
	}
	
}
