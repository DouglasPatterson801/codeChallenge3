//
//  TableViewController.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let storeItemController = StoreItemController()
    
    var items = [StoreItem]()
    var page = 1
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            let query = [
                "s": searchTerm,
                // could add type here "type": segmentController[indexPath.row] (something like that)
                "page": "\(page)"
            ]
                
            storeItemController.fetchItems(matching: query, completion: { (items) in
                
                DispatchQueue.main.async {
                    
                    if let items = items {
                        self.items = items
                        self.tableView.reloadData()
                    } else {
                        print("unable to load data")
                    }
                }
            })
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year
        cell.imageView?.image = UIImage(named: "gray")
        
        let task = URLSession.shared.dataTask(with: item.poster) { (data, response, error) in
            
            guard let imageData = data else {
                return
            }
            
            DispatchQueue.main.async {
                
                let image = UIImage(data: imageData)
                cell.imageView?.image = image
            }
        }
        
        task.resume()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
    
}
