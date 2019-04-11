//
//  UIView.swift
//  Pods
//
//  Created by Santiago Bustamante on 10/5/16.
//
//

import UIKit

//MARK: - UIView
public extension UIView {
    
    
    var height : CGFloat {
        get{return self.frame.size.height}
        set{frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newValue)}
    }
    
    var width : CGFloat {
        get{return self.frame.size.width}
        set{frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.frame.size.height)}
    }
    
    var x : CGFloat {
        get{return self.frame.origin.x}
        set{frame = CGRect(x: newValue, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)}
    }
    
    var y : CGFloat {
        get{return self.frame.origin.y}
        set{frame = CGRect(x: self.frame.origin.x, y: newValue, width: self.frame.size.width, height: self.frame.size.height)}
    }
    
    var yCenter : CGFloat {
        get{return self.y + self.height/2.0}
        set{self.y = yCenter - self.height/2.0}
    }
    
    var xCenter : CGFloat {
        get{return self.x + self.width/2.0;}
        set{self.x = newValue - self.width/2.0}
    }
    
    var cornerRadius : CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius =  newValue
            
        }
        get { return layer.cornerRadius}
    }
    
    var borderWidth : CGFloat {
        set {layer.borderWidth = borderWidth}
        get { return layer.borderWidth}
    }
    
    var borderColor : UIColor {
        set { layer.borderColor =  newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor!)}
    }
    
    /**
     Convert curretn view to image
     
     :returns: return the image
     */
    func toImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return viewImage!
    }
    
    func rotate(duration: Double = 1) {
        let kRotationAnimationKey = "com.barista-v.rotationanimationkey"
        if self.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            self.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    func stopRotating() {
        let kRotationAnimationKey = "com.barista-v.rotationanimationkey"
        if self.layer.animation(forKey: kRotationAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
    
}
