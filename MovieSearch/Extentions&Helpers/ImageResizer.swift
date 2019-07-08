//
//  ImageResizer.swift
//  MovieSearch
//

import UIKit

/// Image resizer. This uses CoreGraphics which is the most effiecent way to resize an image. Find more info here https://nshipster.com/image-resizing/.
///
/// - Parameters:
///   - image: image to resize
///   - size: size to resize the image to
/// - Returns: returns a resized image for use.
func resizeImage(image: UIImage, for size: CGSize) -> UIImage? {
	let render = UIGraphicsImageRenderer(size: size)
	return render.image(actions: { (context) in
		image.draw(in: CGRect(origin: .zero, size: size))
	})
}
