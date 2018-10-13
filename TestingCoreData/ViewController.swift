//
//  ViewController.swift
//  TestingCoreData
//
//  Created by Jamie on 2018-10-13.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var categories: [NSManagedObject] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //get a reference to the appDelegate with has info about the CoreData
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        //get a reference to the context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //get a reference to the entity
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MyCategory")
        
        //do, try, catch
        do {
            categories = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

// Implement the addName IBAction
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Category",
                                      message: "Add a new category",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "MyCategory",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            categories.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(categories)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let category = categories[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                category.value(forKeyPath: "name") as? String
            return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toBeRemoved = categories[indexPath.row]
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            // 1
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(toBeRemoved)
            categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // save()
        }
    }
}
