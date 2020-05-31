//
//  APIWebservice.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation
import MVVMCore
import Alamofire

enum ItunesWebservice: APIWebservice {
    
    case search(offset: Int)
    
    var baseURL: String {
        return "https://itunes.apple.com"
    }
    
    var endpoint: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .search(let offset):
            var dictParams: [String: Any] = ["term": "star", "country": "au", "media": "movie", "limit": 20]
            if offset > 0 {
                dictParams["offset"] = offset
            }
            return dictParams
        }
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    
}
