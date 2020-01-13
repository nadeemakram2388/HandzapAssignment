//
//  AppCoordinator.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.


import Foundation
import UIKit

extension UIAlertController {
    static func show(_ message: String, title: String = "OK", from viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: title, style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
