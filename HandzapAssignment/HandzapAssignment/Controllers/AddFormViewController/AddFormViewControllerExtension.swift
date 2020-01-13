//
//  AddFormViewControllerExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableView Data Source
extension AddFormViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.formFieldData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let obj = viewModel?.formFieldData[indexPath.row] as? FormFields  {
            switch obj {
            case .title, .desc:
                return createSingleInputTextFieldCell(tableView, indexPath: indexPath, formData: obj)
            case .budgetAndCurrancy, .rateAndPayMethod, .startDateAndJobTerm:
                return createDoubleInputTextFieldCell(tableView, indexPath: indexPath, formData: obj)
            }
        } else {
            return UITableViewCell()
        }
    }
}

extension AddFormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AddFormViewController {
    
    func createSingleInputTextFieldCell(_ tableView: UITableView!, indexPath: IndexPath, formData: FormFields)-> BaseInputTextFieldCell {
        
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: InputTextFieldCell.name, for: indexPath as IndexPath) as? InputTextFieldCell else {
            fatalError("Unexpected Index Path")
        }
        cell.delegate = self
        cell.setupForSingleInput(formData: formData, viewModel: self.viewModel)
        return cell
    }

    func createDoubleInputTextFieldCell(_ tableView: UITableView!, indexPath: IndexPath, formData: FormFields)-> BaseInputTextFieldCell {
        
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: DoubleInputTextFieldCell.name, for: indexPath as IndexPath) as? DoubleInputTextFieldCell else {
            fatalError("Unexpected Index Path")
        }
        cell.setupForDoubleInput(formData: formData, viewModel: viewModel)
        cell.delegate = self
        return cell
    }

}

extension AddFormViewController: BaseInputTextFieldCellDelegate {
    
    func baseInputTextFieldDidBeginEditing(txtField: UITextField, formData: FormFields) {
        currentResponder = txtField
        switch formData {
        case .rateAndPayMethod(.rate), .rateAndPayMethod(.payMethod), .startDateAndJobTerm(.jobTerms):
            self.openPicker(formData: formData, txtField: txtField)
            break
        case .startDateAndJobTerm(.startDate):
            self.openDatePicker(txtField: txtField)
            break
        default:break
        }
    }
    
    func baseInputTextFieldTextEndEditing(txtField: UITextField, formData: FormFields) {
        
        currentResponder = nil
        if let formTextField = txtField as? FormTextField {
            switch formData {
            case .title,
                 .budgetAndCurrancy(.budget),
                 .startDateAndJobTerm(.startDate):
                if txtField.text?.isEmpty ?? false {
                    formTextField.error = formData.hint
                }
            default:
                break
            }
        }
    }
    

    func baseInputTextFieldTextDidChanged(txtField: UITextField, text: String, formData: FormFields) {
        currentResponder = txtField
        self.viewModel?.setTextFor(formField: formData, text: text)
        
        if let formTextField = txtField as? FormTextField {
            
            if text.count > 0 {
                formTextField.error = nil
            }

            switch formData {
            case .title:
                formTextField.hint = "\(70 - text.count) characters left"
            case .desc:
                formTextField.hint = "\(330 - text.count) characters left"
            case .budgetAndCurrancy(.budget), .startDateAndJobTerm(.startDate):
                formTextField.hint = formData.hint
            default:
                break
            }

        }
    }
    
    func baseInputTextFieldTextShouldReturn(txtField: UITextField, formData: FormFields) {
        switch formData {
        case .rateAndPayMethod(.rate),
             .rateAndPayMethod(.payMethod),
             .startDateAndJobTerm(.jobTerms),
             .startDateAndJobTerm(.startDate):
            view.endEditing(true)
        default:
        guard let tempText: UITextField = self.view.viewWithTag(txtField.tag + 1) as? UITextField else {return}
        tempText.becomeFirstResponder()
        }
        currentResponder = nil
    }
}

extension AddFormViewController: AttachmentViewDelegate {
    
    func didTapOnAddBtn() {
        self.attachmentHandler?.showAttachmentActionSheet(showFileOption: false, vc: self)
        self.attachmentHandler?.imagePickedBlock = { [weak self](image) in
            let imageItem = SelectedImage()
            imageItem.image = image
            self?.reloadAttachmentViewWith(item: imageItem)
        }
        
        self.attachmentHandler?.videoPickedBlock = { [weak self] (url) in
            
            let urlSafe = url as URL
            let previewImage = self?.attachmentViewModel?.videoPreviewImage(url: urlSafe)
            let item = SelectedVideo(url: url, previewImage: previewImage)
           self?.reloadAttachmentViewWith(item: item)
        }

    }
}
