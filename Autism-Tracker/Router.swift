//
//  Router.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

enum Router {
    
    // Events
    case getAllEvents
    case getEvent(id: String)
    case createEvent(event: Event)
    
}

// MARK: - Base URL
extension Router {
    
    var baseURL: String {
        switch self {
        case .getAllEvents, .createEvent, .getEvent:
            return "https://autism-tracker-server.appspot.com"
        }
    }
    
}

// MARK: - Path
extension Router {
    
    var path: String {
        switch self {
        case .getAllEvents, .createEvent:
            return "/events"
        case .getEvent(let id):
            return "/events\(id)"
        }
    }
    
}

// MARK: - Method
extension Router {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllEvents, .getEvent:
            return .get
        case .createEvent:
            return .post
        }
    }
    
}

// MARK: - Parameters
extension Router {
    
    var parameters: [String: Any]? {
        switch self {
        case .createEvent(let event):
            var dict: [String: Any] = [:]
            dict[JSONKeys.mood] = event.mood
            dict[JSONKeys.stressLevel] = event.stressLevel
            dict[JSONKeys.physicalActivityLevel] = event.physicalActivityLevel
            dict[JSONKeys.selfHarmLevel] = event.selfHarmLevel
            dict[JSONKeys.trigger] = event.trigger
            dict[JSONKeys.resolution] = event.resolution
            dict[JSONKeys.additionalNotes] = event.additionalNotes
            dict[JSONKeys.photoURL] = "NO_URL"
            dict[JSONKeys.time] = time
            return dict
        default:
            return nil
        }
    }
    
}

// MARK: - Headers
extension Router {
    
    var headers: [String: String]? {
        return nil
    }
    
}




