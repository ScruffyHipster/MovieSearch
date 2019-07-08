//
//  HUDView.swift
//  MovieSearch
//

import UIKit

///This is an overlay which can be ammended to show various messages. Image is of a tick however could be changed.
class HUDView: UIView {
	//MARK:- Properites
	var text: String = ""
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		let width: CGFloat = 200
		let height: CGFloat = 200
		let rect = CGRect(x: round((bounds.width - width) / 2), y: round((bounds.height - height) / 2), width: width, height: height)
		let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 12)
		UIColor(white: 0.2, alpha: 0.7).setFill()
		roundedRect.fill()
		if let image = UIImage(named: "Tick") {
			let imageRect = CGRect(x: center.x - round(image.size.width / 2) - 10, y: center.y - round(image.size.height / 2) - height / 8, width: 60, height: 50)
			image.draw(in: imageRect)
		}
		let attributes = [NSAttributedString.Key.font : UsableFonts.hudFont, NSAttributedString.Key.foregroundColor: UsableColours.white]
		let textSize = text.size(withAttributes: attributes as [NSAttributedString.Key : Any])
		let textPoint = CGPoint(x: center.x - round(textSize.width / 2), y: center.y - round(textSize.height / 2) + 60)
		text.draw(at: textPoint, withAttributes: attributes as [NSAttributedString.Key : Any])
	}
	
	
	/// Creates a HUD view for use on various screens where required
	///
	/// - Parameters:
	///   - view: view in which to show HUD
	///   - animated: whether the view is animated
	///   - text: text to display
	/// - Returns: HUDView
	class func showHUDView(in view: UIView, animated: Bool, text: String) -> HUDView {
		let hud = HUDView(frame: view.bounds)
		hud.text = text
		hud.show(animated)
		hud.backgroundColor = .clear
		view.isUserInteractionEnabled = false
		view.addSubview(hud)
		return hud
	}
	
	func show(_ animated: Bool) {
		transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: [], animations: {
			self.alpha = 1.0
			self.transform = .identity
		}, completion: { _ in
			self.hide()
		})
	}
	
	func hide() {
		UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
			self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
		}) { _ in
			self.alpha = 0.0
			self.transform = .identity
			self.removeFromSuperview()
		}
	}
}
