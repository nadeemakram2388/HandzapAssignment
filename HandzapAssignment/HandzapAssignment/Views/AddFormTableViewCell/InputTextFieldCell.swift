//
//  AddFormViewModel.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

class InputTextFieldCell: BaseInputTextFieldCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.txtFieldInput.rightViewMode = UITextFieldViewMode.always
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension InputTextFieldCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let delegate = self.delegate else {return}
        delegate.baseInputTextFieldDidBeginEditing(txtField: textField, formData: self.formData)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let delegate = self.delegate else {return}
        delegate.baseInputTextFieldTextEndEditing(txtField: textField, formData: self.formData)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Length restriction
        
        if let maxLength = self.formData.maximumLength {
            
            let textFieldText: NSString = (textField.text ?? "") as NSString
            let textAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            
            guard let delegate = self.delegate else {fatalError("Delegate is nil")}
            delegate.baseInputTextFieldTextDidChanged(txtField: textField, text: textAfterUpdate, formData: self.formData)

            return textAfterUpdate.count < maxLength
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let delegate = self.delegate else {fatalError("Delegate is nil")}
        delegate.baseInputTextFieldTextShouldReturn(txtField: textField, formData: self.formData)
        return true
    }
}

