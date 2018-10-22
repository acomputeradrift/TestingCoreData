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
    var categories: [Category] = []
    private var appDelegate: AppDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.appDelegate = appDelegate
        }


        title = "Categories"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //get a reference to the appDelegate with has info about the CoreData
        guard let appDelegate = self.appDelegate else {
            assertionFailure("Unable to retrieve app delegate")
            return
        }
        //get a reference to the context
        let managedContext = appDelegate.persistentContainer.viewContext

        //get a reference to the entity
        //let fetchRequest = NSFetchRequest<NSManagedObject>
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Category")

        //do, try, catch
        do {
            categories = try managedContext.fetch(fetchRequest) as! [Category]
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

        guard let appDelegate = self.appDelegate else {
            assertionFailure("Unable to retrieve app delegate")
            return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let category = Category(context: managedContext)
        category.name = name
             //category.setValue(name, forKeyPath: "name")
        let subCategory = SubCategory(context: managedContext)
        subCategory.name = "Income"
        category.sub = [ subCategory ]
        print(category.sub ?? "Didn't Work")

        do {
            try managedContext.save()
            categories.append(category )
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
