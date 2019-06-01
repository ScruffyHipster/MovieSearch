//
//  Alert.swift
//  MovieSearch
//
//  Created by Tom Murray on 26/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

enum AlertScenarios {
	case error
	case notification(notificationMessage: String)
	case noWifi
	case success(successMessage: String)
	
	var message: String {
		switch self {
		case .error:
			return "Oops! An error has occured, please try the action again!"
		case .noWifi:
			return "Oh no! it looks like you have no wifi. Tap to go to settings to get that sorted. Other wise this app is quite dull!"
		case .notification(let notifiction):
			return "\(notifiction)"
		case .success(let message):
			return "\(message)"
		}
	}
	
}

extension UIAlertController {
	
	static func createAlert(alertTitle: String, alertScenario: AlertScenarios, actionTitle: String) -> UIAlertController {
		let alert = UIAlertController(title: alertTitle, message: alertScenario.message, preferredStyle: .alert)
		switch alertScenario {
		case .error:
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		case .noWifi:
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
				//direct to settings.
			}))
			alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
			break
		case .notification( _):
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		case .success( _):
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		}
		return alert
	}
	
}
