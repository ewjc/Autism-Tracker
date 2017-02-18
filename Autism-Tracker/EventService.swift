//
//  EventService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

class EventService {
    
    func getAllEvents(completion: @escaping (([Event]?, Error?) -> Void)) {
        
        Provider.request(route: .getAllEvents) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // If no data, return
            guard let data = data as? [[String: Any]] else {
                completion(nil, nil)
                return
            }
            
            // Create all the public gists
            var events: [Event] = []
            for eventData in data {
                if let event = Event(data: eventData) {
                    events.append(event)
                }
            }

            // Complete
            completion(events, nil)
            
        }
        
    }
    
    func getEvent(id: String, completion: @escaping ((Event?, Error?) -> Void)) {
        
        Provider.request(route: .getEvent(id: id)) { (data: Any?, error: Error?) in
            // do shit
            
            // Error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // If no data, return
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            // Create event
            
        }
        
    }
    
    func createEvent() {
        
        Provider.request(route: .createEvent) { (data: Any?, error: Error?) in
            // do shit
        }
        
    }
    
}
