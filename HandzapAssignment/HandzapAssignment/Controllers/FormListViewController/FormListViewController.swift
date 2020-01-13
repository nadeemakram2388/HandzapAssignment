//
//  FormListViewController.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import UIKit
import CoreData

class FormListViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var formTableView: UITableView!
    //ViewModel
    var viewModel: FormListViewModel?
    //FetchResultController
    var fetchedResultController: NSFetchedResultsController<Form>?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel?.title
        
        // Do any additional setup after loading the view.
        setUpTableView()
        setupNavigationBarButtonItems()
        setupFetchedResultController()
        performFetchRequest()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // performFetchRequest()
    }


    // MARK: - Helper Functions
    private func setUpTableView() {
        formTableView.delegate = self
        formTableView.dataSource = self
        formTableView.tableFooterView = UIView(frame: CGRect.zero)
        formTableView.register(nib: FormTableViewCell.name)
        // accessibilityIdentifier
        formTableView.accessibilityIdentifier = "formTableView"
        formTableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavigationBarButtonItems() {
        let addContactBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addFormBarButtonItemAction))
        navigationItem.rightBarButtonItem = addContactBarButtonItem
    }
    
    private func setupFetchedResultController() {
        let contactsFetchRequest: NSFetchRequest<Form> = Form.fetchRequest()
        contactsFetchRequest.sortDescriptors = []

        let managedObjectContext = CoreDataHelper.shared.managedObjectContext
        fetchedResultController = .init(fetchRequest: contactsFetchRequest,
                                        managedObjectContext: managedObjectContext,
                                        sectionNameKeyPath: nil,
                                        cacheName: nil)
        fetchedResultController?.delegate = self
    }
    
    private func performFetchRequest() {
        do {
            try fetchedResultController?.performFetch()
            formTableView.reloadData()
        } catch {
            Log.error("Unable to perform fetch operation from DB.", error: error)
        }
    }

    
    @objc private func addFormBarButtonItemAction() {
        AppCoordinator.toAddForm(navController: self.navigationController)
    }
}

extension FormListViewController {
    
    func showDeleteOption(forForm: Form) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            forForm.delete()
        }
        let deleteIcon = UIImage(named: "Trash icon")
        deleteAction.setValue(deleteIcon?.withRenderingMode(.alwaysOriginal), forKey: "image")

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}

