//
//  UIViewExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit
protocol PickerDelegate: class {
    func pickerValue(_ picker: Picker, title:String?, rowObj: AnyObject?)
    
}

class Picker: UIPickerView {
    
    var pickerData: [AnyObject]? {
        didSet {
            self.reloadAllComponents()
        }
    }
    
    var key:String?
    var formData: FormFields?
    weak var pickerDelegate: PickerDelegate?
    
    func commonInit(){
        
        self.dataSource = self
        self.delegate   = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
}

extension Picker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerData?.first is String || key != nil {
            return pickerData?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if key != nil {
            return pickerData?[row][key!] as? String
        } else if pickerData?[row] is String {
            return (pickerData?[row] as? String ?? "")
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var title: String?
        if key != nil {
            title = pickerData?[row][key!] as? String
        } else {
            title = pickerData?[row] is String ? pickerData?[row] as! String : ""
        }
        self.pickerDelegate?.pickerValue(self, title: title, rowObj: pickerData?[row])
    }
}
