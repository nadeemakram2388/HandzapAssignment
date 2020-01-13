//
//  AddFormViewModel.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

class AddFormViewModel {
    
    let title = AppText.NewForm.localized
    let rightBarButtonTitle = AppText.Send.localized
    var formFieldData = FormFields.allValues
    
    let datePickerMaxDate = Calendar.current.date(byAdding: .year, value: 20, to: Date())
    let datePickerMinDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())

    var form: Form!
    
    init() {
    }
    
    convenience init(form: Form) {
        self.init()
        self.form = form
    }
    
    func textFor(formField: FormFields) -> String? {
        switch formField {
        case .title: return form.title
        case .desc: return form.desc
        case .budgetAndCurrancy(.budget): return form.budget
        case .budgetAndCurrancy(.currancy): return "USD"
        case .rateAndPayMethod(.rate): return form.rate
        case .rateAndPayMethod(.payMethod): return form.payMethod
        case .startDateAndJobTerm(.startDate): return form.startDate
        case .startDateAndJobTerm(.jobTerms): return form.jobTerms
        }
    }
    
    func setTextFor(formField: FormFields, text: String?) {
        switch formField {
        case .title: self.form.title = text
        case .desc: self.form.desc = text
        case .budgetAndCurrancy(.budget): self.form.budget = text
        case .budgetAndCurrancy(.currancy): break
        case .rateAndPayMethod(.rate):  self.form.rate = text
        case .rateAndPayMethod(.payMethod): self.form.payMethod = text
        case .startDateAndJobTerm(.startDate): self.form.startDate = text
        case .startDateAndJobTerm(.jobTerms): self.form.jobTerms = text
        }
    }
    
    func doubleInputForm(formField: FormFields) -> (FormFields, FormFields)? {
        switch formField {
        case .budgetAndCurrancy(.budget), .budgetAndCurrancy(.currancy):
            return (.budgetAndCurrancy(.budget), .budgetAndCurrancy(.currancy))
        case .rateAndPayMethod(.rate), .rateAndPayMethod(.payMethod):
            return (.rateAndPayMethod(.rate), .rateAndPayMethod(.payMethod))
        case .startDateAndJobTerm(.startDate), .startDateAndJobTerm(.jobTerms):
            return (.startDateAndJobTerm(.startDate), .startDateAndJobTerm(.jobTerms))
        default:
            return nil
        }
    }
    
    func pickerDataFor(formField: FormFields) -> [String] {
        switch formField {
        case .rateAndPayMethod(.rate):
            return ["No Preference", "Fixed Budget", "Hourly Rate"]
        case .rateAndPayMethod(.payMethod):
            return ["No Preference", "E-Payment", "Cash"]
        case .startDateAndJobTerm(.jobTerms):
            return ["No Preference", "Recurring Job", "Same Day Job", "Multi Days Job"]
        default: return []
        }
    }


}

