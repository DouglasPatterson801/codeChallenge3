//
//  URL+Helpers.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
