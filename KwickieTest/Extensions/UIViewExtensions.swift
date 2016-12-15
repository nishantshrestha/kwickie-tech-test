//
//  UIViewExtensions.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 16/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit

// Credit to Brian Voong from Letsbuildthatapp.
extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
