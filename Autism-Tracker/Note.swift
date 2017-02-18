//
//  Event.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class Note {
    
    // MARK: - Instace Vars
    var id: String!
    
    var mood: String!
    var stressLevel: Int!
    
    var physicalActivityLevel: Int!
    var selfHarmLevel: Int!
    
    var trigger: String!
    var resolution: String!
    var additionalNotes: String!
    
    var photo: UIImage!
    var time: String!
    
    // MARK: - Init
    init() {
        
    }
    
    init(id: String, mood: String, stressLevel: Int, physicalActivityLevel: Int, selfHarmLevel: Int, trigger: String, resolution: String, additionalNotes: String, photo: UIImage, time: String) {
        self.id = id
        self.mood = mood
        self.stressLevel = stressLevel
        self.physicalActivityLevel = physicalActivityLevel
        self.selfHarmLevel = selfHarmLevel
        self.trigger = trigger
        self.resolution = resolution
        self.additionalNotes = additionalNotes
        self.photo = photo
        self.time = time
    }
    
    init?(data: [String: Any]) {
        
        // TODO: Add stuff
        print("Hello")
        
    }
    
}
