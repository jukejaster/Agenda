//
//  ListController.swift
//  Agenda
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    private var viewModel = ListViewModel()
    
    // MARK: - @IBActions
    @IBAction func addListItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add List Item", message: "Add an item that you need to do.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, let text = textField.text  else {
                // execute code if textField doesn't exist
                return
            }
            
            self?.viewModel.addListItem(with: text)
            self?.tableView.reloadData()
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "List item..."
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listItemCell")
        cell.textLabel?.text = viewModel.listItems[indexPath.row].name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeListItem(with: viewModel.listItems[indexPath.row].name)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
