//
//  UIView+Utilities.swift
//  GithubGist
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Nicholas Swift. All rights reserved.
//

import UIKit

extension UIView {
    
    class func toString() -> String {
        let name = NSStringFromClass(self)
        let components = name.components(separatedBy: ".")
        
        guard let classString = components.last
            else { fatalError("Error: couldn't convert class name to string.") }
        
        return classString
    }
    
    class func hsf_nibNamed(nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: Bundle.main)
    }
    
    class func hsf_nib() -> UINib {
        return hsf_nibNamed(nibName: self.toString())
    }
    
    class func instanceFromNib() -> UIView {
        
        let view = hsf_nib().instantiate(withOwner: nil, options: nil)[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
}
