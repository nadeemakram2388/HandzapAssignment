//
//  UIViewExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func datePickerValueChanged(_ datePicker: DatePicker, date: Date, formattedDateStr:String)
}

class DatePicker: UIDatePicker {
    weak var delegate: DatePickerDelegate?
    var dateFormat: String?

    // MARK: - Private methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(DatePicker.datePickerValueChanged), for: .valueChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(DatePicker.datePickerValueChanged), for: .valueChanged)
    }
}

extension DatePicker {
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        if let dtFormatter = self.dateFormat {
            dateFormatter.dateFormat = dtFormatter
        }else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        let strDate = dateFormatter.string(from: self.date)
        self.delegate?.datePickerValueChanged(self, date: self.date, formattedDateStr: strDate)
    }
}
