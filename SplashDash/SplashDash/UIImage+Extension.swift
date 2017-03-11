//
//  UIImage+Extension.swift
//  SplashDash
//
//  Created by Tong Lin on 3/9/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        guard let cgImg = self.cgImage else { return UIImage() }
        context.clip(to: rect, mask: cgImg)
        context.fill(rect)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
