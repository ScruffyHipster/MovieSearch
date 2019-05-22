//
//  Coordinator.swift
//  MovieSearch
//
//  Created by Tom Murray on 15/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
	var childCoordinator: [Coordinator] {get set}
	var navigationController: UINavigationController {get set}
	
	func start()
}

