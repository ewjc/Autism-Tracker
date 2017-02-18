//
//  EventService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

class EventService {
    
    // MARK: - Get All Events
    static func getAllEvents(completion: @escaping (([Event]?, Error?) -> Void)) {
        
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
    
    // MARK: - Get Event
    static func getEvent(id: String, completion: @escaping ((Event?, Error?) -> Void)) {
        
        Provider.request(route: .getEvent(id: id)) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // If no data, return
            guard let data = data as? [String: Any] else {
                completion(nil, nil)
                return
            }
            
            // Create event
            let event = Event(data: data)
            
            // Complete
            completion(event, nil)
        }
    }
    
    // MARK: - Create Event
    static func createEvent(id: String, mood: String, stressLevel: Int, physicalActivityLevel: Int, selfHarmLevel: Int, trigger: String, resolution: String, additionalNotes: String, photo: UIImage, time: String, completion: @escaping ((Event?, Error?) -> Void)) {
        
        Provider.request(route: .createEvent) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                completion(nil, error)
                return
            }
            
            // If no data, return
            guard let data = data as? [String: Any] else {
                completion(nil, nil)
                return
            }
            
            // Create returned event
            let event = Event(data: data)
            
            // Complete
            completion(event, nil)
        }
    }
    
}
