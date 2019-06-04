//
//  SearchResultsView.swift
//  MovieSearch
//

import UIKit

class SearchResultsView: UIView {
	//MARK:- Properties
	var backgroundContainerView: GradientContainerView = {
		let view = GradientContainerView(colorOne: nil, colorTwo: nil)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var collectionViewDelegate: SearchResultsCollectionViewDelegate? {
		didSet {
			collectionView.delegate = self.collectionViewDelegate
			collectionView.dataSource = self.collectionViewDelegate
			collectionView.reloadData()
		}
	}
	
	var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.searchResultCVCell.identity)
		return collectionView
	}()
	
	//MARK:-Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		collectionView.backgroundColor = UIColor.clear

	}
	
	func configure() {
		setUpView()
	}
}

extension SearchResultsView {
	private func setUpView() {
		[backgroundContainerView].forEach({addSubview($0)})
	  [collectionView].forEach({backgroundContainerView.addSubview($0)})
		setUpBackGroundContainer()
		setUpCollectionView()
	}
	
	private func setUpBackGroundContainer() {
		backgroundContainerView.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
	}
	
	private func setUpCollectionView() {
		
		collectionView.delegate = collectionViewDelegate
		collectionView.dataSource = collectionViewDelegate
		collectionView.anchor(top: backgroundContainerView.safeAreaLayoutGuide.topAnchor, trailing: backgroundContainerView.safeAreaLayoutGuide.trailingAnchor, bottom: backgroundContainerView.safeAreaLayoutGuide.bottomAnchor, leading: backgroundContainerView.safeAreaLayoutGuide.leadingAnchor)
	}
}
