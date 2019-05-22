//
//  SearchResultsCollectionViewDelegate.swift
//  MovieSearch
//
//  Created by Tom Murray on 20/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsCollectionViewDelegate: NSObject, DataHandlerProtocol {
	
	var resultsHandler: ResultsDataHandler?
	
	var resultsData: [AnyObject]? {
		get {
			return resultsHandler?.retriveDataFromHandeler()
		}
	}
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let data = resultsData else {
			print("here as the data is not loaded")
			return 10
		}
		print("data count is \(data.count)")
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.searchResultCVCell.identity, for: indexPath) as! SearchResultCollectionViewCell
		
		cell.titleLabel.text = "The Avengers"
		cell.ratingText.text = "8 / 10"
	
		
		cell.configureImage(image: UIImage(named: "posterPlaceholder")!)
		

		return cell
	}
	
	
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDelegate {
	
}

extension SearchResultsCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width = collectionView.bounds.width
		let height = collectionView.bounds.height
		
		if UIDevice.current.orientation.isLandscape {
			return CGSize(width: width / 4, height: height)
		} else {
			return CGSize(width: width, height: height)
		}
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		if UIDevice.current.orientation.isLandscape {
			return 20
		} else {
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	

}


