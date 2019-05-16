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
	
	static func moveAnimationY(layer: CALayer, to: CGFloat, duration: Double) {
		let position = CABasicAnimation(keyPath: "position.y")
		position.toValue = to
		position.duration = duration
		position.isRemovedOnCompletion = false
		position.fillMode = CAMediaTimingFillMode.forwards
		layer.add(position, forKey: nil)
	}
	
	static func moveAnimationX(layer: CALayer, to: CGFloat, duration: Double) {
		let position = CABasicAnimation(keyPath: "position.x")
		position.toValue = to
		position.duration = duration
		position.isRemovedOnCompletion = false
		position.fillMode = CAMediaTimingFillMode.forwards
		layer.add(position, forKey: nil)
	}
}
