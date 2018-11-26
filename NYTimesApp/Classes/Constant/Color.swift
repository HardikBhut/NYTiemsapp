//
//  Color.swift
//  NYTimesapp
//
//  Created by Hardik on 25/11/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import Foundation
import UIKit

let kBackGround_Color: UIColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
let kTitle_Color: UIColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
let kWhite_Color: UIColor = UIColor(red: 255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
let ksubTitle_color: UIColor = UIColor(red: 148.0/255.0, green: 148.0/255.0, blue: 148.0/255.0, alpha: 1.0)
let kgreen_color: UIColor = UIColor(red: 0.0/255.0, green: 226.0/255.0, blue: 188.0/255.0, alpha: 1.0)
let kimg_color: UIColor = UIColor(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1.0)


extension UIImageView {
    
    func maskWith(color: UIColor) {
        guard let tempImage = image?.withRenderingMode(.alwaysTemplate) else { return }
        image = tempImage
        tintColor = color
    }
    
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            print(self.frame.width)
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
    func addBorder1(edge: UIRectEdge, color: UIColor, thickness: CGFloat, height1 : CGFloat) {
        print(height1)
    }
    
    
}

extension UIImage {
    public func image(withTintColor color: UIColor) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIButton {
    func imageWith(color:UIColor, for: UIControl.State) {
        if let imageForState = self.image(for: state) {
            self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            let colorizedImage = imageForState.image(withTintColor: color)
            self.setImage(colorizedImage, for: state)
        }
    }
}


