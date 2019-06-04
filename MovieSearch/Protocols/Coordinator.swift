//
//  Coordinator.swift
//  MovieSearch
//

import UIKit

///Coordinator protocol to setup conformance. For more information on the Coordiantor set up please visit http://khanlou.com/2015/10/coordinators-redux/. Saroush Khan is the main man behind the coordinator pattern. Also, https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps for a quick start and indepth look at the pattern from Paul Hudson. 
protocol Coordinator: class {
	var childCoordinator: [Coordinator] {get set}
	var navigationController: UINavigationController {get set}
	
	func start()
}

