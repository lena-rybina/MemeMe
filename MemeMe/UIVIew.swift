//
//  UIVIew.swift
//  MemeMe v2.0
//
//  Created by Elena Rybina on 6/8/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func generateMemedImage() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (memedImage != nil) {
            return memedImage!
        }
        return UIImage()
    }
    
}
