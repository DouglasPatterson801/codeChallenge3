//
//  StoreItemController.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

struct StoreItemController {
    
    func fetchItems(matching query: [String: String], completion: @escaping (Movie?) -> Void) {
        
        
        let apiKey = "apikey=ec7544d4"
        let baseURL = URL(string: "http://www.omdbapi.com/?&\(apiKey)")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries")
            return
        }
        
     
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            
            let jsonObjects = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictionary = jsonObjects as? Dictionary<String, Any> {
                
                print(dictionary.description)
                
                guard let results = Movie(dictionary: dictionary) else {
                    print("Error")
                    return
                }
                completion(results)
                self.saveToPersistentStorage()
                
            }
            
  
        }
        
        task.resume()
    }
    
    
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.context.save()
        } catch {
            print("Error. Unable to save to persistent storage")
        }
        
    }
}

