//
//  BaseInputTextFieldCell.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

protocol BaseInputTextFieldCellDelegate: class {
    
    func baseInputTextFieldDidBeginEditing(txtField: UITextField, formData: FormFields)
    func baseInputTextFieldTextDidChanged(txtField: UITextField, text: String, formData: FormFields)
    func baseInputTextFieldTextEndEditing(txtField: UITextField, formData: FormFields)
    func baseInputTextFieldTextShouldReturn(txtField:UITextField, formData: FormFields)
}

class BaseInputTextFieldCell: UITableViewCell {

    //Outlet
    @IBOutlet weak var txtFieldInput: FormTextField!
    //Delegate
    weak var delegate: BaseInputTextFieldCellDelegate?
    //DataSource
    var formData: FormFields = FormFields.title
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Setup
        self.txtFieldInput.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.txtFieldInput.font = UIFont.systemFont(ofSize: 16)
        self.txtFieldInput.errorLabel.font = UIFont.systemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupForSingleInput(formData: FormFields, viewModel: AddFormViewModel?) {
        
        self.formData = formData
        self.txtFieldInput.placeholder = formData.placeholder
        self.txtFieldInput.hint = formData.hint
        self.txtFieldInput.keyboardType = formData.keyboardType
        self.txtFieldInput.returnKeyType = formData.returnKeyType
        self.txtFieldInput.text = viewModel?.textFor(formField: formData)
        self.txtFieldInput.tag = formData.tag
    }

}
