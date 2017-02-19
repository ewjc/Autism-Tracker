//
//  MicrosoftService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Foundation

class MicrosoftService {
    
    static func getEmotion(imageURL: String, completion: @escaping (String) -> Void) {
        
        Provider.request(route: .getEmotion(imageURL: imageURL)) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                completion("Sorry, could not determine emotion")
                return
            }
            
            // If no data, return
            guard let data = data as? [[String: Any]] else {
                completion("Sorry could not determine emotion")
                return
            }
            
            let emotionsDict = data[0]["scores"] as! [String: Float]
            
            var maxValue: Float = 0
            var maxKey: String = "Sorry, could not determine emotion"
            for item in emotionsDict {
                if item.value > maxValue {
                    maxValue = item.value
                    maxKey = item.key
                }
            }
            
            completion(maxKey)
        }
        
    }
    
}
