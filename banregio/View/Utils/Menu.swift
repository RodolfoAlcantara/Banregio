//
//  Menu.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    class func actionMenu(estadoDelMenu: Bool, constraint: NSLayoutConstraint, view: UIView) -> Bool{
        if (estadoDelMenu){
            constraint.constant = 490
            
            
            UIView.animate(withDuration: 0.3, animations: {
                view.layoutIfNeeded()
            })
        } else {
            constraint.constant = 70
            
            
            UIView.animate(withDuration: 0.3, animations: {
                view.layoutIfNeeded()
            })
        }
        return !estadoDelMenu
    }
    
    class func setScrollMenu(scroll: UIScrollView, viewToScroll: UIView){
        let height = viewToScroll.bounds.height
        let width = viewToScroll.bounds.width
        scroll.contentSize.height = height
        scroll.contentSize.width = width
        viewToScroll.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scroll.addSubview(viewToScroll)
    }
    
    class func hidedMenu(constraintMenu: NSLayoutConstraint){
        constraintMenu.constant = 490
        
    }
    
    class func showedMenu(constraintMenu: NSLayoutConstraint){
        constraintMenu.constant = 0
        
    }
    
    class func shadowed(viewShadowed: UIView, width: CGFloat, height: CGFloat, op: Float, radius: CGFloat){
        viewShadowed.layer.shadowColor = UIColor.black.cgColor
        viewShadowed.layer.shadowOpacity = op
        viewShadowed.layer.shadowOffset = CGSize(width: width, height: height)
        viewShadowed.layer.shadowRadius = radius
    }
    
    
}
