//
//  AppCoordinator.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.

import Foundation
import UIKit

extension UITableView {
    
    // Register nib on UITableView...
    func register(nib nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
}
