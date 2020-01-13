//
//  AddFormViewController.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit

class AddFormViewController: UIViewController {

    @IBOutlet weak var addFormTableView: UITableView!
    @IBOutlet weak var attachementView: AttachmentView!

    var viewModel: AddFormViewModel?
    var dataPicker: Picker?
    var datePicker: DatePicker?
    var attachmentHandler: AttachmentHandler?
    var attachmentViewModel: AttachmentViewModel?

    var currentResponder: UITextField?
    var backFromBackBtn: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = viewModel?.title
        
        // Do any additional setup after loading the view.
        setUpTableView()
        setupNavigationBarButtonItems()
        setupAttachmentview()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if backFromBackBtn {
            self.viewModel?.form.delete()
        }
    }

    deinit {
        print("")
    }

    // MARK: - Helper Functions
    private func setUpTableView() {
        addFormTableView.delegate = self
        addFormTableView.dataSource = self
        addFormTableView.tableFooterView = UIView(frame: CGRect.zero)
        addFormTableView.register(nib: InputTextFieldCell.name)
        addFormTableView.register(nib: DoubleInputTextFieldCell.name)
        // accessibilityIdentifier
        addFormTableView.accessibilityIdentifier = "addFormTableView"
        addFormTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavigationBarButtonItems() {
        let sendBarButtonItem = UIBarButtonItem(title: viewModel?.rightBarButtonTitle, style: .done, target: self, action: #selector(sendFormBarButtonItemAction))
        navigationItem.rightBarButtonItem = sendBarButtonItem
    }
    
    private func setupAttachmentview() {
        self.attachementView.delegate = self
    }

    func reloadAttachmentViewWith(item: Any) {
        self.attachementView.arrItem.append(item)
    }
    
    @objc private func sendFormBarButtonItemAction() {
        self.backFromBackBtn = false
        self.viewModel?.form.saveToDataBase()
        self.navigationController?.popViewController(animated: true)
    }

}

extension AddFormViewController {
    func openAttachmentHandler() {
    }
    
    func openPicker(formData: FormFields, txtField: UITextField) {
        dataPicker?.pickerDelegate = self
        dataPicker?.formData = formData
        dataPicker?.key = nil
        dataPicker?.pickerData = self.viewModel?.pickerDataFor(formField: formData) as [AnyObject]?
        txtField.inputView = dataPicker
    }
    
    func openDatePicker(txtField: UITextField) {
        
        datePicker?.delegate = self
        datePicker?.datePickerMode = UIDatePicker.Mode.date
        datePicker?.maximumDate = self.viewModel?.datePickerMaxDate
        datePicker?.minimumDate = self.viewModel?.datePickerMinDate
        txtField.inputView = datePicker
    }
}

//MARK: Gender picker delegate methods
extension AddFormViewController: PickerDelegate {
    func pickerValue(_ picker: Picker, title: String?, rowObj: AnyObject?) {
        if let formData = picker.formData {
            self.viewModel?.setTextFor(formField: formData, text: title)
        }
        currentResponder?.text = title
    }
}

// MARK: - Date picker delegate methods
extension AddFormViewController: DatePickerDelegate {
    func datePickerValueChanged(_ datePicker: DatePicker, date: Date, formattedDateStr: String) {
        self.viewModel?.setTextFor(formField: .startDateAndJobTerm(.startDate), text: title)
        currentResponder?.text = formattedDateStr
    }
}



