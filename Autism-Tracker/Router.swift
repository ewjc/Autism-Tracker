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
    case createEvent
    
}

// MARK: - Base URL
extension Router {
    
    var baseURL: String {
        switch self {
        case .getAllEvents, .createEvent, .getEvent:
            return "https://herokuapp.com"
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
    
    var parameters: [String: String]? {
        return nil
    }
    
}

// MARK: - Headers
extension Router {
    
    var headers: [String: String]? {
        return nil
    }
    
}




