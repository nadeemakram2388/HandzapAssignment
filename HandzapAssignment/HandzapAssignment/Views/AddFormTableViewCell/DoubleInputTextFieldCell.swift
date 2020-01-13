//
//  AddFormViewModel.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

class DoubleInputTextFieldCell: BaseInputTextFieldCell {

    //Outlet
    @IBOutlet weak var txtFieldInput2: FormTextField!
    //DataSource
    var formData2: FormFields = FormFields.budgetAndCurrancy(.budget)
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.txtFieldInput.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldInput.font = UIFont.systemFont(ofSize: 16)
        self.txtFieldInput.errorLabel.font = UIFont.systemFont(ofSize: 12)

        self.txtFieldInput2.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldInput2.font = UIFont.systemFont(ofSize: 16)
        self.txtFieldInput2.errorLabel.font = UIFont.systemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupForDoubleInput(formData: FormFields, viewModel: AddFormViewModel?) {
        self.formData = formData
        
        if let tuple = viewModel?.doubleInputForm(formField: formData) {
            self.formData = tuple.0
            self.setupForSingleInput(formData: tuple.0, viewModel: viewModel)
            
            let secondFormData = tuple.1
            self.formData2 = secondFormData

            self.txtFieldInput2.placeholder = secondFormData.placeholder
            self.txtFieldInput2.hint = secondFormData.hint
            self.txtFieldInput2.keyboardType = secondFormData.keyboardType
            self.txtFieldInput2.returnKeyType = secondFormData.returnKeyType
            self.txtFieldInput2.text = viewModel?.textFor(formField: formData)
            self.txtFieldInput2.tag = formData.tag
            
            if self.formData2.placeholder == "" { //Currancy
                self.txtFieldInput2.setIcon(UIImage(named: "US")!)
                self.txtFieldInput2.isUserInteractionEnabled = false
                self.txtFieldInput2.text = viewModel?.textFor(formField: self.formData2)
            }
        }
    }
}

extension DoubleInputTextFieldCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let delegate = self.delegate else {return}
        delegate.baseInputTextFieldDidBeginEditing(txtField: textField, formData: (textField == txtFieldInput ?  self.formData : self.formData2))
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let delegate = self.delegate else {return}
        delegate.baseInputTextFieldTextEndEditing(txtField: textField, formData: (textField == txtFieldInput ?  self.formData : self.formData2))
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let textAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        guard let delegate = self.delegate else {fatalError("Delegate is nil")}
        delegate.baseInputTextFieldTextDidChanged(txtField: textField, text: textAfterUpdate, formData: (textField == txtFieldInput ?  self.formData : self.formData2))
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let delegate = self.delegate else {fatalError("Delegate is nil")}
        delegate.baseInputTextFieldTextShouldReturn(txtField: textField, formData: (textField == txtFieldInput ?  self.formData : self.formData2))
        return true
    }
    
}
