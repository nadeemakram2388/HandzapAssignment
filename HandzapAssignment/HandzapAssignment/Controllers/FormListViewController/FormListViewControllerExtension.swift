//
//  FormListViewControllerExtension.swift
//  HandzapAssignment
//
//  Created by Nadeem Akram on 11/01/20.
//  Copyright © 2020 Nadeem Akram. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - NSFetchResultController Delegate
extension FormListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        formTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            formTableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            formTableView.deleteRows(at: [indexPath!], with: .none)
        case .update:
            formTableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            formTableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            formTableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            formTableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        case .update:
            formTableView.reloadSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        formTableView.endUpdates()
    }
}

// MARK: - UITableView Data Source
extension FormListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.sections?[section].objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.name,
                                                       for: indexPath) as? FormTableViewCell else {
                                                        fatalError("Unable to dequeue FormTableViewCell.")
        }
        cell.delegate = self
        cell.accessibilityIdentifier = String(format: "FormTableViewCell_%ld_%ld", indexPath.section, indexPath.row)
        let object = fetchedResultController!.object(at: indexPath)
        cell.configureFor(form: object)
        return cell
    }
}

extension FormListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension FormListViewController: FormTableViewCellDelegate {
    func didTapOnOptionBtn(cell: FormTableViewCell?) {
        guard let cellSafe = cell,
            let indexPath = self.formTableView.indexPath(for: cellSafe),
            let form = fetchedResultController?.object(at: indexPath) else {
            return
        }
        showDeleteOption(forForm: form)
    }
}
