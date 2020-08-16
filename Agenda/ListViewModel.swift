//
//  ListViewModel.swift
//  Agenda
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

struct ListViewModel {
    var listItems: [ListItem] {
        return CoreDataController.shared.listItems
    }
    
    func addListItem(with name: String) {
        CoreDataController.shared.addListItem(with: name)
    }
    
    func removeListItem(with name: String?) {
        guard let name = name else { return }
        
        CoreDataController.shared.removeListItem(with: name)
    }
}
