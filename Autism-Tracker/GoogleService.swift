//
//  GoogleService.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/19/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import Foundation
import SwiftyJSON

class GoogleService {
    
    static func getGoogleEmotion(imageData: String, completion: @escaping (String) -> Void) {
        
        Provider.request(route: .getGoogleEmotion(imageData: imageData) { (data: Any?, error: Error?) in
            
            // Error
            if let error = error {
                completion("Sorry, could not determine emotion")
                return
            }
            
            // If no data, return
            guard let data = data as? [String: Any] else {
                completion("Sorry could not determine emotion")
                return
            }
            
            // Parse through json
            
            let responses: JSON = json["responses"][0]
            let faceAnnotations: JSON = responses["faceAnnotations"]
            
            if faceAnnotations != nil {
                let emotions: [String] = ["joy", "sorrow", "surprise", "anger"]
                let numPeopleDetected: Int = faceAnnotations.count
                
                self.faceResults.text = "People detected: \(numPeopleDetected)\n\nEmotions detected:\n"
                
//                var emotionTotals: [String: Double] = ["sorrow": 0, "joy": 0, "surprise": 0, "anger": 0]
//                var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY":0.25, "VERY_UNLIKELY": 0.0]
//                
//                for index in 0..<numPeopleDetected {
//                    let personData:JSON = faceAnnotations[index]
//                    
//                    // Sum all the detected emotions
//                    for emotion in emotions {
//                        let lookup = emotion + "Likelihood"
//                        let result:String = personData[lookup].stringValue
//                        emotionTotals[emotion]! += emotionLikelihoods[result]!
//                    }
//                }
//                // Get emotion likelihood as a % and display in UI
//                for (emotion, total) in emotionTotals {
//                    let likelihood:Double = total / Double(numPeopleDetected)
//                    let percent: Int = Int(round(likelihood * 100))
//                    self.faceResults.text! += "\(emotion): \(percent)%\n"
//                }
//                
//                let surprise = "\(faceAnnotations[0]["surpriseLikelihood"])"
//                let angry = "\(faceAnnotations[0]["angerLikelihood"])"
//                let joyful = "\(faceAnnotations[0]["joyLikelihood"])"
//                let sad = "\(faceAnnotations[0]["sorrowLikelihood"])"
//                
//                self.labelResults.text = "Surprise: \(surprise), Angry: \(angry), Joyful: \(joyful), Sad: \(sad)"
//            
//            let emotionsDict = data[0]["scores"] as! [String: Float]
//            
//            var maxValue: Float = 0
//            var maxKey: String = "Sorry, could not determine emotion"
//            for item in emotionsDict {
//                if item.value > maxValue {
//                    maxValue = item.value
//                    maxKey = item.key
//                }
//            }
//            
//            completion(maxKey)
//        }
//        
//    }
    
}
