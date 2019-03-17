//
//  ViewController.swift
//  MilestoneProject2
//
//  Created by John Nyquist on 3/16/19.
//  Copyright © 2019 Nyquist Art + Logic LLC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = add
        navigationItem.rightBarButtonItem = share

        toolbarItems = [spacer, trash]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    
    //MARK: - #selector
    
    @objc func shareTapped() {
        let listAsString = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [listAsString],
                                          applicationActivities: [])
        
        /* This line of code tells iOS to anchor the activity view
         controller to the right bar button item (our share button),
         but this only has an effect on iPad – on iPhone it's ignored. */
        vc.popoverPresentationController?.barButtonItem = toolbarItems?[0]
        
        present(vc, animated: true)
    }
    
    @objc func clearList() {
        shoppingList = []
        tableView.reloadData()
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let item = ac.textFields![0]
            self.submit(item: item.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func submit(item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    // MARK: - UITableViewDataSource protocol
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}

