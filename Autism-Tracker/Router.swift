//
//  Router.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

enum Router {
    
    // Notes
    case getAllNotes
    case getNote(id: String)
    case createNote(note: Note)
    
}

// MARK: - Base URL
extension Router {
    
    var baseURL: String {
        switch self {
        case .getAllNotes, .createNote, .getNote:
            return "https://autism-tracker-server.appspot.com"
        }
    }
    
}

// MARK: - Path
extension Router {
    
    var path: String {
        switch self {
        case .getAllNotes, .createNote:
            return "/events"
        case .getNote(let id):
            return "/events\(id)"
        }
    }
    
}

// MARK: - Method
extension Router {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllNotes, .getNote:
            return .get
        case .createNote:
            return .post
        }
    }
    
}

// MARK: - Parameters
extension Router {
    
    var parameters: [String: Any]? {
        switch self {
        case .createNote(let note):
            var dict: [String: Any] = [:]
            dict[JSONKeys.mood] = note.mood
            dict[JSONKeys.stressLevel] = note.stressLevel
            dict[JSONKeys.physicalActivityLevel] = note.physicalActivityLevel
            dict[JSONKeys.selfHarmLevel] = note.selfHarmLevel
            dict[JSONKeys.trigger] = note.trigger
            dict[JSONKeys.resolution] = note.resolution
            dict[JSONKeys.additionalNotes] = note.additionalNotes
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




