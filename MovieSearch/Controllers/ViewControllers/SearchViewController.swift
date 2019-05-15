//
//  ViewController.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
	
	weak var coordinator: SearchCoordinator?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

extension SearchViewController: Storyboarded {
	
}
