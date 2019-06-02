//
//  Storyboarded.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
	static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
	static func instantiate() -> Self {
		//Get the name of the class from the controller eg: MyApp.ViewController
		let fullName = NSStringFromClass(self)
		//This removes the name post . so will return the view controller name
		let className = fullName.components(separatedBy: ".")[1]
		//get the storyboard as we do not use a intial entry point
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		//load the view controller into the storyboard
		return storyboard.instantiateViewController(withIdentifier: className) as! Self
	}
}
