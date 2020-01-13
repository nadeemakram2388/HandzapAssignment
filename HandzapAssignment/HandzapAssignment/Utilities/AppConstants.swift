//
//  AppConstants.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    
}

enum AppText: String {
    
    case AddIcon = "+"
    case Send = "Send"
    case NewForm = "New Form"
    
    case formTitle = "Form Title"
    case formListing = "Form Listing"
    case formDescription = "Form Descriptions"
    case Budget = "Budget"
    case Rate = "Rate"
    case PaymentMethod = "Payment Method"
    case StartDate = "Start Date"
    case JobTerm = "Job Term"

        // Mark- Localized Value
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

enum Color {
    case themeColor
    case textInputColor
    case errorColor
    case hintColor
    case lineColor
    case navigationBarColor
    case navigationItemColor
}

class AppColor {
    class func color(_ color: Color) -> UIColor {
        switch color {
        case .themeColor:
            return UIColor(red: 44/255.0, green: 78/255.0, blue: 104/255.0, alpha: 1.0)
        case .textInputColor:
            return UIColor(red: 44/255.0, green: 78/255.0, blue: 104/255.0, alpha: 1.0)
        case .errorColor:
            return .red
        case .hintColor:
            return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1.0)
        case .lineColor:
            return UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1.0)
        case .navigationBarColor:
                return UIColor(red: 44/255.0, green: 78/255.0, blue: 104/255.0, alpha: 1.0)
        case .navigationItemColor:
            return UIColor(red: 44/255.0, green: 78/255.0, blue: 104/255.0, alpha: 1.0)

        }
    }
}

