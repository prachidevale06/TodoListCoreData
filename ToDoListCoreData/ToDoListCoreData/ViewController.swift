//
//  ViewController.swift
//  ToDoListCoreData
//
//  Created by Prachi on 14/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // we want to grab viewcontext from persistent
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [ToDOListItem]()
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
            title = "To Do list"
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            getAllItem()
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action:#selector(didTapAction))
        
        }
    @objc private func didTapAction (){
        let alert = UIAlertController(title: "New Item", message: "Enter the New item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]_ in
            guard let  field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:   indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
      // core Data
    func getAllItem(){
        do {
            models = try context.fetch(ToDOListItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDOListItem(context: context)
        newItem.name = nibName
        newItem.createdAt = Date()
        do{
            try context.save()
            getAllItem()
        }
        catch {
        }
    }
    
    func deleteItem(item: ToDOListItem){
        context.delete(item)
        do{
            try context.save()
        }
        catch {
        }
    }
    
    func updateItem(item: ToDOListItem,newName: String) {
        item.name = newName
        do{
            try context.save()
        }
        catch {
        }
    }

}





