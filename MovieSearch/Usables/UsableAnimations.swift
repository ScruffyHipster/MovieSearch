//
//  UsableAnimations.swift
//  MovieSearch
//
//  Created by Tom Murray on 16/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

class UsableAniamtions {
	///Fade the layer opacity
	static func fade(layer: CALayer, from: CGFloat, to: CGFloat, duration: Double) {
		let fade = CABasicAnimation(keyPath: "opacity")
		fade.toValue = to
		fade.fromValue = from
		fade.isRemovedOnCompletion = false
		fade.fillMode = CAMediaTimingFillMode.forwards
		layer.add(fade, forKey: nil)
	}
	
	///Scale and fade animation
	static func scaleDownFade(view: UIView, direction: Direction) -> UIViewPropertyAnimator {
		let scale = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn)
		switch direction {
		case .down:
			scale.addAnimations {
				view.transform = .identity
				view.alpha = 1.0
			}
		case .up:
			scale.addAnimations {
				view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
				view.alpha = 0.0
			}
		}
		return scale
	}
	///Rotate the layer
	static func rotate(layer: CALayer, reversed: Bool) {
		let rotation = CABasicAnimation(keyPath: "transform.rotation")
		rotation.duration = 0.5
		rotation.fromValue = 0.0
		rotation.toValue = reversed ? (Double.pi / 2) : (Double.pi / 3)
		layer.add(rotation, forKey: nil)
	}	
}
