//
//  VisualFX.swift
//  banregio
//
//  Created by Benjamin on 04/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//


import UIKit

class VisualFX {
    
    class func setBottomBorder( textsFields: UITextField ... ) {
        let colorBlack = UIColor( red: 255/255, green: 255/255, blue: 255/255, alpha: 1 )
        for text in textsFields {
            setBottomBorder( textFields: text, color: colorBlack )
        }
    }
    
    class func setBottomBorder( textFields: UITextField ..., color: UIColor ) {
        var border : CALayer = CALayer()
        let width = CGFloat( 2.0 )
        
        for textField in textFields {
            border = CALayer()
            textField.borderStyle = .none
            border.borderColor = color.cgColor
            border.frame = CGRect( x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height )
            
            if var sublayer = textField.layer.sublayers {
                sublayer.removeAll()
            }
            
            textField.layer.masksToBounds = true
            border.zPosition = -1
            border.borderWidth = width
            textField.layer.addSublayer( border )
            textField.layer.layoutSublayers()
        }
    }
}

