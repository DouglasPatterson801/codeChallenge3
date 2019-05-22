//
//  StoreItemController.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

struct StoreItemController {
    
    func fetchItems(matching query: [String : String], completion: @escaping ([Movie]?) -> Void) {
        
        
        let apiKey = "apikey=ec7544d4"
        let baseURL = URL(string: "http://www.omdbapi.com/?&\(apiKey)")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries")
            return
        }
     
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let storeItems = try? decoder.decode(StoreItems.self, from: data) {
                completion(storeItems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
}
