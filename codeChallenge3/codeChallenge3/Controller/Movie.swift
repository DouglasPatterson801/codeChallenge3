//
//  Movie.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/21/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation
import CoreData

extension Movie {
    
    convenience init?(dictionary: Dictionary<String, Any>, context: NSManagedObjectContext = Stack.context) {
        guard let title = dictionary["Title"] as? String,
            let year = dictionary["Year"] as? String,
            let poster = dictionary["Poster"] as? String else { return nil }
        
        self.init(context: context)
        
        self.title = title
        self.year = year
        self.poster = poster
        
    }
}
