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
    
    // Image Recognition
    case getEmotion(imageURL: String)
    
}

// MARK: - Base URL
extension Router {
    
    var baseURL: String {
        switch self {
        case .getAllNotes, .createNote, .getNote:
            return "https://autism-tracker-server.appspot.com"
        case .getEmotion:
            return "https://westus.api.cognitive.microsoft.com"
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
        case .getEmotion:
            return "/emotion/v1.0/recognize"
        }
    }
    
}

// MARK: - Method
extension Router {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllNotes, .getNote:
            return .get
        case .createNote, .getEmotion:
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
            dict[JSONKeys.photoURL] = "https://avatars0.githubusercontent.com/u/6567880?v=3&s=400"
            dict[JSONKeys.time] = note.time
            return dict
        case .getEmotion(let imageURL):
            return ["url": "https://avatars0.githubusercontent.com/u/6567880?v=3&s=400"]
        default:
            return nil
        }
    }
    
}

// MARK: - Headers
extension Router {
    
    var headers: [String: String]? {
        switch self {
        case .createNote:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .getEmotion:
            return ["Ocp-Apim-Subscription-Key": "987595b243524947add847c7d6a673b5",
                    "Content-Type": "application/json"]
        default:
            return nil
        }
    }
    
}




