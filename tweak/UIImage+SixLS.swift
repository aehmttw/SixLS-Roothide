//
//  UIImage+resize.swift
//  SixLS
//
//  Created by Skitty on 11/28/20.
//  Copyright © 2020 Skitty. All rights reserved.
//

import UIKit
import roothide

extension UIImage {
	func imageResized(to targetSize: CGSize) -> UIImage? {
		let widthRatio  = targetSize.width / size.width
		let heightRatio = targetSize.height / size.height

		var newSize: CGSize
		if widthRatio > heightRatio {
			newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
		} else {
			newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
		}

		let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

		UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
		draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return newImage
	}

	class func forSix(named name: String) -> UIImage? {
#if TWEAK
		let path = jbroot("/Library/Application Support/Six/\(name).png")
		if access("/var/jb/", F_OK) == 0 {
			return UIImage(contentsOfFile: "/var/jb" + path)
		}
		return UIImage(contentsOfFile: path)
#else
		return UIImage(named: name)
#endif
	}
}
