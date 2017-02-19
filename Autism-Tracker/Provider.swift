//
//  Provider.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

class Provider {
    
    static func request(route: Router, completion: @escaping ((Any?, Error?) -> Void)) {
        
        // Create variables
        let url = route.baseURL + route.path
        let routeMethod = route.method
        let headers = route.headers
        var parameters = route.parameters
        parameters?["time"] = nil
        
        // Make request
        Alamofire.request(url, method: route.method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { response in
            
            switch response.result {
                
            // Success
            case .success(let value):
                completion(value, nil)
                
            // Failure
            case .failure(let error):
                completion(nil, error)
                
            }
        }
    }
    
}
