//
//  CustomButton.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton:  UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshBorder(borderWidth: borderWidth)
        refreshBorderColor(colorBorder: borderCEnabled)
        setBackgroundColor(color: backCEnable, forState: .normal)
        setBackgroundColor(color: backCDisabled, forState: .disabled)
        setTitleColor(by: textCEnable, for: .normal)
        setTitleColor(by: textCDisabled, for: .disabled)
    }
    
    /* Background */
    @IBInspectable var backCEnable : UIColor = UIColor.backCEnable {
        didSet {
            setBackgroundColor(color: backCEnable, forState: .normal)
        }
    }
    @IBInspectable var backCDisabled : UIColor = UIColor.backCEnable {
        didSet {
            setBackgroundColor(color: backCDisabled, forState: .disabled)
        }
    }
    
    /* Corner */
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    /* Border */
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            refreshBorder(borderWidth: borderWidth)
        }
    }
    
    func refreshBorder( borderWidth: CGFloat) {
        layer.borderWidth =  borderWidth
    }
    /* Border Color Enable */
    @IBInspectable var borderCEnabled : UIColor = UIColor.borderColorBtn {
        didSet {
            setBackgroundColor(color: borderCEnabled, forState: .normal)
        }
    }
    /* Border Color Disabled */
    @IBInspectable var borderCDisabled : UIColor = UIColor.borderColorBtn{
        didSet {
            setBackgroundColor(color: borderCEnabled, forState: .disabled)
        }
    }
    
    func refreshBorderColor( colorBorder: UIColor) {
        layer.borderColor = colorBorder.cgColor
    }
    /* Text Color */
    @IBInspectable var textCEnable : UIColor = UIColor.white{
        didSet {
            self.setTitleColor(textCEnable, for: .normal)
        }
    }
    @IBInspectable var textCDisabled : UIColor = UIColor.lightGray {
        didSet {
            self.setTitleColor(textCDisabled, for: .disabled)
        }
    }
    func setTitleColor(by color: UIColor?, for state: UIControl.State) {
        self.setTitleColor(color, for: state)
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
