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
    var id: Int!
    
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
    
    init(mood: String, stressLevel: Int, physicalActivityLevel: Int, selfHarmLevel: Int, trigger: String, resolution: String, additionalNotes: String, photo: UIImage, time: String) {
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
        self.id = data[JSONKeys.id] as! Int
        self.mood = data[JSONKeys.mood] as! String
        self.stressLevel = data[JSONKeys.stressLevel] as! Int
        self.physicalActivityLevel = data[JSONKeys.physicalActivityLevel] as! Int
        self.selfHarmLevel = data[JSONKeys.selfHarmLevel] as! Int
        self.trigger = data[JSONKeys.trigger] as! String
        self.resolution = data[JSONKeys.resolution] as! String
        self.additionalNotes = data[JSONKeys.additionalNotes] as! String
//        self.photo = data[JSONKeys.photo]
        self.time = data[JSONKeys.time] as! String
    }
    
}
