//
//  DetailsView.swift
//  MovieSearch
//
//  Created by Tom Murray on 23/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class DetailsView: UIView {
	
	//MARK:- Properties
	
	var imageViewTopContstraint: NSLayoutConstraint?
	var imageViewLeadingConstraint: NSLayoutConstraint?
	var imageViewWidthConstraint: NSLayoutConstraint?
	var imageViewHeightAnchor: NSLayoutConstraint?
	
	var InfoStackTopConstraint: NSLayoutConstraint?
	var InfoStackTrailingConstraint: NSLayoutConstraint?
	var InfoStackLeadingConstraint: NSLayoutConstraint?
	var InfoStackBottomConstraint: NSLayoutConstraint?
	
	var orientation: Orientation?
	
	var gradientImageContainerView: GradientImageContainer = {
		var container = GradientImageContainer(frame: .zero)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.backgroundColor = .clear
		return container
	}()
	
	var informationContainerView: MovieInfoView = {
		var view = MovieInfoView(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		return view
	}()
	
	var likeButton: UIButton = {
		var likeButton = UIButton(frame: .zero)
		likeButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
		likeButton.setImage(#imageLiteral(resourceName: "likeSelected"), for: .focused)
		likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
		return likeButton
	}()

	var dismissButton: UIButton = {
		var dismissButton = UIButton(frame: .zero)
		dismissButton.setImage(#imageLiteral(resourceName: "crossButton"), for: .normal)
		return dismissButton
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	convenience init?(orientation: Orientation) {
		self.init()
		self.orientation = orientation
		setUpView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//MARK:- Setup
extension DetailsView {
	
	private func setUpView() {
		[gradientImageContainerView, informationContainerView].forEach({addSubview($0)})
		guard let orientation = orientation else {
			setUpTopImageView()
			setUpBottomDetailsView()
			return
		}
		switch orientation {
		case .portrait:
			portrait()
		case .landscape:
			landscape()
		}
		setUpHeaderButtons()
	}
	
	private func setUpTopImageView() {
		
		imageViewTopContstraint = gradientImageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
		imageViewLeadingConstraint = gradientImageContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
		imageViewWidthConstraint = gradientImageContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
		imageViewHeightAnchor = gradientImageContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
		
		NSLayoutConstraint.activate([
			imageViewTopContstraint!,
			imageViewLeadingConstraint!,
			imageViewWidthConstraint!,
			imageViewHeightAnchor!
			])
	}
	
	private func setUpBottomDetailsView() {
		
		InfoStackTopConstraint = informationContainerView.topAnchor.constraint(equalTo: gradientImageContainerView.bottomAnchor, constant: 0)
		InfoStackLeadingConstraint = informationContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0)
		InfoStackTrailingConstraint = informationContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
		InfoStackBottomConstraint = informationContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
		
		NSLayoutConstraint.activate([
			InfoStackTopConstraint!,
			InfoStackLeadingConstraint!,
			InfoStackTrailingConstraint!,
			InfoStackBottomConstraint!
			])
	}
	
	private func setUpHeaderButtons() {
		[dismissButton, likeButton].forEach({self.addSubview($0)})
		dismissButton.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: nil, bottom: nil, leading: safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 22, left: 10, bottom: 0, right: 0), size: .init(width: 44, height: 44))
		likeButton.anchor(top: safeAreaLayoutGuide.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: nil, leading: nil, padding: .init(top: 22, left: 0, bottom: 0, right: -10), size: .init(width: 44, height: 44))
	}
	
}

extension DetailsView {
	func landscape() {
		informationContainerView.bottomInfoStack.isHidden = true
		informationContainerView.infoLabel.isHidden = true
		informationContainerView.seperatorLine.isHidden = true
		informationContainerView.ratingInfoStack.isHidden = true
		//TODO:- look at resizing image on rotation
		gradientImageContainerView.mainImage.contentMode = .scaleAspectFill
		//ImageView
		[imageViewTopContstraint, imageViewLeadingConstraint, imageViewWidthConstraint, imageViewHeightAnchor, InfoStackTopConstraint, InfoStackTrailingConstraint, InfoStackBottomConstraint, InfoStackLeadingConstraint].forEach({$0?.isActive = false})
		
		imageViewTopContstraint = gradientImageContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 42)
		imageViewLeadingConstraint = gradientImageContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 72)
		imageViewWidthConstraint = gradientImageContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
		imageViewHeightAnchor = gradientImageContainerView.heightAnchor.constraint(equalTo: self.informationContainerView.heightAnchor, multiplier: 1.0)
		
		
		//InfoView
		InfoStackTopConstraint = informationContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)
		InfoStackTrailingConstraint = informationContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -58)
		InfoStackLeadingConstraint = informationContainerView.leadingAnchor.constraint(equalTo: gradientImageContainerView.trailingAnchor, constant: 50)
		InfoStackBottomConstraint = informationContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40)
		
		NSLayoutConstraint.activate([
			imageViewTopContstraint!,
			imageViewLeadingConstraint!,
			imageViewHeightAnchor!,
			imageViewWidthConstraint!,
			
			InfoStackTopConstraint!,
			InfoStackTrailingConstraint!,
			InfoStackLeadingConstraint!,
			InfoStackBottomConstraint!
			])
	}
	
	func portrait() {
		[imageViewTopContstraint, imageViewLeadingConstraint, imageViewWidthConstraint, imageViewHeightAnchor, InfoStackTopConstraint, InfoStackTrailingConstraint, InfoStackBottomConstraint, InfoStackLeadingConstraint].forEach({$0?.isActive = false})
		
		UIView.animate(withDuration: 0.5) {
			self.informationContainerView.bottomInfoStack.isHidden = false
			self.informationContainerView.infoLabel.isHidden = false
			self.informationContainerView.seperatorLine.isHidden = false
			self.informationContainerView.ratingInfoStack.isHidden = false
		}
		
		
		setUpTopImageView()
		setUpBottomDetailsView()
	}
}

//MARK:- Functions
extension DetailsView {
	
	//Move this to the view controller.
	@objc func didTapLikeButton() {
		print("tapped like button")
	}
	
}
