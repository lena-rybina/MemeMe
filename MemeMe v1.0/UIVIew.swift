//
//  UIVIew.swift
//  MemeMe v1.0
//
//  Created by Elena Rybina on 6/8/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil) {
            return image!
        }
        return UIImage()
    }
}
