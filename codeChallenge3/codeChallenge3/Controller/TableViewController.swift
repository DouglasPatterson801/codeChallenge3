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
    
    var movies = [Movie]()
    var items = [Movie]()
    var page = 1
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            let query = ["s": "\(searchTerm)", "apikey": "ec7544d4"]
                
            storeItemController.fetchItems(matching: query, completion: { (items) in
                
                DispatchQueue.main.async {
                    
                    if let items = items {
//                        self.items = items
                        self.tableView.reloadData()
                    } else {
                        print("unable to load data")
                    }
                }
            })
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let movie = items[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.year
        cell.imageView?.image = UIImage(named: "gray")
        
        
        guard let poster = movie.poster,
        let posterURL = URL(string: poster) else { return }
        let task = URLSession.shared.dataTask(with: posterURL) { (data, respone, error) in
//        let task = URLSession.shared.dataTask(with: item.poster) { (data, response, error) in
        
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
