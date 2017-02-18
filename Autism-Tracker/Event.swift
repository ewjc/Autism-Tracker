//
//  Event.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Foundation

class Event {
    
    // MARK: - Instace Vars
    var id: String!
    
    var mood: String
    var stressLevel: Int
    
    var physicalActivityLevel: Int
    var selfHarmLevel: Int
    
    var trigger: String
    var resolution: String
    var additionalNotes: String
    
    var photo: Data
    var time: String
    
    // MARK: - Init
    init?(data: [String: Any]) {
        
        // TODO: Add stuff
        print("Hello")
        
    }
    
}
