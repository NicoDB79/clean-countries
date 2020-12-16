//
//  RoundedCornerView.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
