//
//  ViewController.swift
//  Day32
//
//  Created by henry on 05/03/2019.
//  Copyright © 2019 HenryNguyen. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var itemArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        let add = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "clear"), style: .plain, target: self, action: #selector(clearItems))
       
        
//        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
         navigationItem.rightBarButtonItems = [add, share]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    @objc func addNewItem(){
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: { (action) in
            guard let item = alert.textFields?[0].text else { return }
            self.submit(item)
        }))
        present(alert, animated:  true)
    }
    
    func submit(_ item: String){
        itemArray.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearItems(){
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.itemArray.removeAll()
            self.tableView.reloadData()
        }))
        present(alert,animated: true)
        
    }
    
    @objc func shareList(){
        let list = itemArray.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

