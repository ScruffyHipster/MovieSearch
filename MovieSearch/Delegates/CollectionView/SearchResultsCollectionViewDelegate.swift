//
//  SearchResultsCollectionViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultsSelectionDelegate: class {
	func didSelectMovieAt(_ IMDBid: String)
}

class SearchResultsCollectionViewDelegate: NSObject, DataHandlerProtocol {
	
	var resultsHandler: ResultsDataHandler?
	
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
	
	//If true the device is in portrait. False the device is in landscape.
	var orientation: Bool {
		get {
			return UIDevice.current.orientation.isPortrait ? true : false
		}
	}
	
	weak var delegate: SearchResultsSelectionDelegate?
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
		
		cell.configureCell(with: data[indexPath.row] as! SearchResults)
		
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
		if !orientation {
			return 20
		} else {
			return 10
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		if !orientation {
			return 5
		} else {
			return 10
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
	}
	

}


