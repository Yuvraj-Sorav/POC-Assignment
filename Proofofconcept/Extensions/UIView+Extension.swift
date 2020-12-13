//
//  UIView+Extension.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.clipsToBounds = true
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    func displayToast(_ message : String, _ tabBarHeight : CGFloat = 80.0) {
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        if let toast = window.subviews.first(where: { $0 is UILabel && $0.tag == -1001 }) {
            toast.removeFromSuperview()
        }
        let bottomSafeArea = window.safeAreaInsets.bottom
        let toastLabel = UILabel(frame: CGRect(x: 20.0, y: DeviceSize.screenHeight-(bottomSafeArea + tabBarHeight), width: DeviceSize.screenWidth-40, height: 60))
        
        toastLabel.textColor = .black
        toastLabel.backgroundColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: Font.kSystemBold, size: 16.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.borderColor = UIColor.gray
        toastLabel.borderWidth = 1.0
        toastLabel.layer.cornerRadius = 30
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        toastLabel.tag = -1001
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(toastLabel)
        
        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
        
        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: (self.frame.size.width-25) )
        
        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[toastView(==60)]-100-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["toastView": toastLabel])
        
        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            toastLabel.alpha = 1.0
            toastLabel.center.y -= toastLabel.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                toastLabel.alpha = 0.0
                toastLabel.center.y += toastLabel.bounds.height
                self.layoutIfNeeded()
            }, completion: { finished in
                toastLabel.removeFromSuperview()
            })
        })
    }
    
}
