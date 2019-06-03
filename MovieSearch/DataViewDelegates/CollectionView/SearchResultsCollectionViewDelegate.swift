//
//  SearchResultsCollectionViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit
import Motion

protocol SearchResultsSelectionDelegate: class {
	func didSelectMovieAt(_ IMDBid: String)
}

///Collection view data source and delegate for the search collection
class SearchResultsCollectionViewDelegate: NSObject, DataHandlerProtocol {
	//MARK:- Properties
	weak var delegate: SearchResultsSelectionDelegate?
	var resultsHandler: ResultsDataHandler?
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
	var orientation: Orientation {
		get {
			return UIDevice.current.orientation.isPortrait ? Orientation.portrait : Orientation.landscape
		}
	}
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let data = resultsData else {
			return 0
		}
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.searchResultCVCell.identity, for: indexPath) as! SearchResultCollectionViewCell
		guard let data = resultsData else {return cell}
		let info = data[indexPath.row] as! SearchResults
		cell.configureCell(with: info)
		cell.mainImage.motionIdentifier = "\(info.imdbID)"
		cell.titleLabel.motionIdentifier = "\(info.title)"
		cell.mainImage.transition([MotionModifier.forceNonFade, MotionModifier.useScaleBasedSizeChange])
		return cell
	}
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let data = resultsData else {return}
		let movie = data[indexPath.row] as! SearchResults
		delegate?.didSelectMovieAt(movie.imdbID)
	}
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width =  collectionView.bounds.width
		let height = collectionView.bounds.height
		
		if UIDevice.current.orientation.isLandscape {
			return CGSize(width: (width - 30) / 4, height: height - 10)
		}
		if UIDevice.current.orientation.isPortrait {
			return CGSize(width: (width - 30) / 2, height: (height / 2) - 10)
		} else {
			return CGSize(width: 0, height: 0)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		switch orientation {
		case .portrait:
			return 10
		case .landscape:
			return 20
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		switch orientation {
		case .portrait:
			return 10
		case .landscape:
			return 5
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
	}
}


