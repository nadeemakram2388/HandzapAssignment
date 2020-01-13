//
//  UIViewExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func initializeFromNib(nibNamed: String) {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibNamed, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }
}
