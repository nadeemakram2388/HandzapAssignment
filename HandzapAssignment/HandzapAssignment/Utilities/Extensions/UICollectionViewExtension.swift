//
//  UICollectionViewExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCellWithCollection(nibName:String, reuseIdentifier:String) {
        self.register(UINib(nibName: nibName, bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier);
    }
}
