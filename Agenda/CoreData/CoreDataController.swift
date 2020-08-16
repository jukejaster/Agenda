//
//  CoreDataController.swift
//  Agenda
//
//  Created by Justin on 3/27/20.
//  Copyright © 2020 justncode LLC. All rights reserved.
//

import CoreData
import Foundation

struct CoreDataController {
    static let shared = CoreDataController()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AgendaModel")
        
        container.loadPersistentStores { description, error in
            // if error exists, crash
            if let error = error {
                fatalError("Something went wrong. We were unable to load the peristent stores. Error: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    var listItems: [ListItem] {
        do {
            return try persistentContainer.viewContext.fetch(NSFetchRequest<ListItem>(entityName: "ListItem"))
        } catch let error {
            print("Unable to retrieve list items \(error.localizedDescription)")
            return []
        }
    }
    
    func addListItem(with name: String) {
        let listItem = NSEntityDescription.insertNewObject(forEntityName: "ListItem", into: persistentContainer.viewContext) as? ListItem
        
        listItem?.setValue(name, forKey: "name")
        
        save()
    }
    
    func removeListItem(with name: String) {
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                             argumentArray: ["name", name])
        
        do {
            guard let listItem = try persistentContainer.viewContext.fetch(fetchRequest).first else {
                // item doesn't exist in core data
                return
            }
            
            // delete it
            persistentContainer.viewContext.delete(listItem)
            save()
        } catch let error {
            print("Unable to delete list item with name \(name). Error:", error.localizedDescription)
        }
    }
    
    private func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Unable to save. Error:", error.localizedDescription)
        }
    }
}
