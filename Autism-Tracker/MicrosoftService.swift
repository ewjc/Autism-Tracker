//
//  MicrosoftService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Foundation

class MicrosoftService {
    
    static func getEmotion() {
        
        Provider.request(route: .getEmotion) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                return
            }
            
            // If no data, return
            guard let data = data as? [[String: Any]] else {
                return
            }
            
            print(data)
            
        }
        
    }
    
}
