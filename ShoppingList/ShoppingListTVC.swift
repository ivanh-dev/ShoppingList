//
//  ShoppingListTVC.swift
//  ShoppingList
//
//  Created by Ivan Hirsinger on 25.08.2022..
//

import UIKit

class ShoppingListTVC: UITableViewController {
    
    var shopingList: [String] = []
    
    class Cell: UITableViewCell {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        self.tableView.register(Cell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableView.fillerRowHeight = 1
    }
    
    func setUi() {
        setResetListButton()
        setRightBarButton()
        setTitle()
    }
    
    func setTitle() {
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToList))
    }
    
    
    func setResetListButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetListButton))
    }
    
    
    @objc func resetListButton() {
        shopingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    func setTextField() {
        let ac = UIAlertController(title: "New Item", message: "What do you want to add to list?", preferredStyle: .alert)
        ac.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
                guard let item = ac?.textFields?[0].text else { return }
                self?.updateShoppingList(item)
        }
        ac.addAction(addItemAction)
        present(ac, animated: true) {
            ac.view.superview?.isUserInteractionEnabled = true
            ac.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
    }
    
    @objc func dismissOnTapOutside() {
        self.dismiss(animated: true)
    }
    
    
    func updateShoppingList(_ item: String) {
        shopingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    @objc func addItemToList() {
        setTextField()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var cellConfigurator = cell.defaultContentConfiguration()
        cellConfigurator.text = shopingList[indexPath.row]
        
        cell.contentConfiguration = cellConfigurator
        return cell
    }
    
}
