//
//  Alert.swift
//  MovieSearch
//

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
			return "Oh no! it looks like you have no wifi. Tap to go to settings to get that sorted. Other wise this app is quite dull without it!"
		case .notification(let notifiction):
			return "\(notifiction)"
		case .success(let message):
			return "\(message)"
		}
	}
}

extension UIAlertController {
	/// Creates an alert with or without preset messages.
	///
	/// - Parameters:
	///   - alertTitle: The alert title
	///   - alertScenario: The scenario in which the alert is being produced
	///   - actionTitle: Action title ("OK" / "Cancel" etc)
	/// - Returns: Alert controller
	static func createAlert(alertTitle: String, alertScenario: AlertScenarios, actionTitle: String) -> UIAlertController {
		let alert = UIAlertController(title: alertTitle, message: alertScenario.message, preferredStyle: .alert)
		switch alertScenario {
		case .error:
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		case .noWifi:
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
				UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
			}))
			break
		case .notification( _):
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		case .success( _):
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
		}
		return alert
	}
}
