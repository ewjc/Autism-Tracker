//
//  NoteService.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Alamofire

class NoteService {
    
    // MARK: - Get All Notes
    static func getAllNotes(completion: @escaping (([Note]?, Error?) -> Void)) {
        
        Provider.request(route: .getAllNotes) { (data: Any?, error: Error?) in
            
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
            var notes: [Note] = []
            for noteData in data {
                if let note = Note(data: noteData) {
                    notes.insert(note, at: 0)
                }
            }

            // Complete
            completion(notes, nil)
        }
    }
    
    // MARK: - Get Note
    static func getNote(id: String, completion: @escaping ((Note?, Error?) -> Void)) {
        
        Provider.request(route: .getNote(id: id)) { (data: Any?, error: Error?) in
            
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
            
            // Create note
            let note = Note(data: data)
            
            // Complete
            completion(note, nil)
        }
    }
    
    // MARK: - Create Note
    static func createNote(note: Note, completion: @escaping ((Note?, Error?) -> Void)) {
        
        Provider.request(route: .createNote(note: note)) { (data: Any?, error: Error?) in
            
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
            
            // Create returned note
            let note = Note(data: data)
            
            // Complete
            completion(note, nil)
        }
    }
    
}
