//
//  UIViewHelper.swift
//  MovieSearch
//
//  Created by Tom Murray on 18/05/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import Foundation
import UIKit

///Image resizer. This uses CoreGraphics which is the most effiecent way.
func resizeImage(image: UIImage, for size: CGSize) -> UIImage? {
	let render = UIGraphicsImageRenderer(size: size)
	return render.image(actions: { (context) in
		image.draw(in: CGRect(origin: .zero, size: size))
	})
}

extension UIView {
	
	///Helper method to add constraints to views
	func anchor(top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
		}
		if let leading = leading {
			leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
		}
		if let trailing = trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
		}
		
		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
		
	}
	
}
