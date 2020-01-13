//
//  AppCoordinator.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppCoordinator {
    
    class func getRootController() -> UINavigationController {
        let formListViewController = FormListViewController(nibName: FormListViewController.name, bundle: nil)
        formListViewController.viewModel = FormListViewModel()
        return UINavigationController(rootViewController: formListViewController)
    }

    class func toAddForm(navController: UINavigationController?) {
        let addFormViewController = AddFormViewController(nibName: AddFormViewController.name, bundle: nil)
        let managedObjectContext = CoreDataHelper.shared.managedObjectContext
        addFormViewController.viewModel = AddFormViewModel(form: Form(context: managedObjectContext))
        addFormViewController.attachmentViewModel = AttachmentViewModel()

        addFormViewController.dataPicker = Picker()
        addFormViewController.datePicker = DatePicker()
        addFormViewController.attachmentHandler = AttachmentHandler.shared

        navController?.pushViewController(addFormViewController, animated: true)
    }    
}
