//
//  EventService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

class EventService {
    
    func getAllEvents() {
        
        Provider.request(route: .getAllEvents) { (data: Any?, error: Error?) in
            
            // Do shit
        }
        
    }
    
    func getEvent(id: String) {
        
        
        
    }
    
    func createEvent() {
        
    }
    
}
