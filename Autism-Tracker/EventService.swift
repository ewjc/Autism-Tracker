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
        
        Provider.request(route: .getEvent(id: id)) { (data: Any?, error: Error?) in
            // do shit
        }
        
    }
    
    func createEvent() {
        
        Provider.request(route: .createEvent) { (data: Any?, error: Error?) in
            // do shit
        }
        
    }
    
}
