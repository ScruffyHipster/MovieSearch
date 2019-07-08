//
//  UIViewHelper.swift
//  MovieSearch
//

import UIKit

///Helper method to deactivate constraints passed in.
func deactivateConstraints(_ constraints: NSLayoutConstraint...) {
	constraints.forEach({$0.isActive = false})
}

extension UIView {
	
	/// Helper method to add constraints to views quickly, this also applies the translatesAutoResizingMask for convienece
	///
	/// - Parameters:
	///   - top: top anchor of superview
	///   - trailing: trailing anchor of superview
	///   - bottom: bottom anchor of superview
	///   - leading: leading anchor of superview
	///   - padding: padding from superview
	///   - size: size of view 
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
