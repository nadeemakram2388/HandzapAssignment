//
//  AddFormFieldModel.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

let titleTag = 5001
let descTag = 5002
let budgetTag = 5003
let currancyTag = 5004
let rateTag = 5005
let payMethodTag = 5006
let startDateTag = 5007
let jobTermTag = 5008


// Model for SignUp / Login page for its fields
enum FormFields {
    
    case title
    case desc
    case budgetAndCurrancy(BudgetAndCurrancyFields)
    case rateAndPayMethod(RateAndPayMethodFields)
    case startDateAndJobTerm(StartDateAndJobTermFields)

    static let allValues = [title, desc, budgetAndCurrancy(.budget), rateAndPayMethod(.rate), startDateAndJobTerm(.startDate)] as [Any]
    
    enum BudgetAndCurrancyFields {
        case budget
        case currancy
    }
    enum RateAndPayMethodFields {
        case rate
        case payMethod
    }
    enum StartDateAndJobTermFields {
        case startDate
        case jobTerms
    }

    var placeholder:String {

        switch self {
        case .title: return
            AppText.formTitle.localized
        case .desc: return AppText.formDescription.localized
        case .budgetAndCurrancy(.budget): return AppText.Budget.localized
        case .budgetAndCurrancy(.currancy): return ""
        case .rateAndPayMethod(.rate): return AppText.Rate.localized
        case .rateAndPayMethod(.payMethod): return AppText.PaymentMethod.localized
        case .startDateAndJobTerm(.startDate): return AppText.StartDate.localized
        case .startDateAndJobTerm(.jobTerms): return AppText.JobTerm.localized
        }
    }
    
    var hint:String? {
        
        switch self {
        case .title, .budgetAndCurrancy(.budget), .startDateAndJobTerm(.startDate): return "Required"
        default:
            return nil
        }
    }


    var keyboardType: UIKeyboardType {

        switch self {
        case .title: return .default
        case .desc: return .default
        case .budgetAndCurrancy(.budget): return .numberPad
        case .budgetAndCurrancy(.currancy): return .default
        case .rateAndPayMethod(.rate): return .default
        case .rateAndPayMethod(.payMethod): return .default
        case .startDateAndJobTerm(.startDate): return .default
        case .startDateAndJobTerm(.jobTerms): return .default
        }
    }

    var returnKeyType:UIReturnKeyType {

        switch self {
        case .startDateAndJobTerm(.jobTerms): return UIReturnKeyType.default
        default: return UIReturnKeyType.next
        }
    }


    var isActionSheetType:Bool {

        switch self {
        case .rateAndPayMethod(.rate): return true
        case .rateAndPayMethod(.payMethod): return true
        case .startDateAndJobTerm(.startDate): return true
        case .startDateAndJobTerm(.jobTerms): return true
         default: return false
        }
    }
    
    var tag:Int {
        
        switch self {
        case .title: return titleTag
        case .desc: return descTag
        case .budgetAndCurrancy(.budget): return budgetTag
        case .budgetAndCurrancy(.currancy): return currancyTag
        case .rateAndPayMethod(.rate): return rateTag
        case .rateAndPayMethod(.payMethod): return payMethodTag
        case .startDateAndJobTerm(.startDate): return startDateTag
        case .startDateAndJobTerm(.jobTerms): return jobTermTag

        }
    }
    
    var maximumLength: Int? {
        switch self {
        case .title: return 70
        case .desc: return 330
        default: return nil
        }
    }

}
