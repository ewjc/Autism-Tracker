//
//  GoogleImageRecognizeVC.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/19/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit
import SwiftyJSON

class ImageRecognizeVC: UIViewController, UIImagePickerControllerDelegate {
    let imagePicker = UIImagePickerController()
    let session = URLSession.shared
    
    var googleAPIKey = "AIzaSyAKry8rIJ9LnJLFihe6yyVmM-u_1y4FUrg"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }

}

extension ViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        DispatchQueue.main.async(execute: {
            
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.spinner.stopAnimating()
            self.imageView.isHidden = true
            self.labelResults.isHidden = false
            self.faceResults.isHidden = false
            self.faceResults.text = ""
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
                // Get face annotations
                let faceAnnotations: JSON = responses["faceAnnotations"]
                if faceAnnotations != nil {
                    let emotions: Array<String> = ["joy", "sorrow", "surprise", "anger"]
                    
                    let numPeopleDetected:Int = faceAnnotations.count
                    
                    self.faceResults.text = "People detected: \(numPeopleDetected)\n\nEmotions detected:\n"
                    
                    var emotionTotals: [String: Double] = ["sorrow": 0, "joy": 0, "surprise": 0, "anger": 0]
                    var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY":0.25, "VERY_UNLIKELY": 0.0]
                    
                    for index in 0..<numPeopleDetected {
                        let personData:JSON = faceAnnotations[index]
                        
                        // Sum all the detected emotions
                        for emotion in emotions {
                            let lookup = emotion + "Likelihood"
                            let result:String = personData[lookup].stringValue
                            emotionTotals[emotion]! += emotionLikelihoods[result]!
                        }
                    }
                    // Get emotion likelihood as a % and display in UI
                    for (emotion, total) in emotionTotals {
                        let likelihood:Double = total / Double(numPeopleDetected)
                        let percent: Int = Int(round(likelihood * 100))
                        self.faceResults.text! += "\(emotion): \(percent)%\n"
                    }
                    
                    let surprise = "\(faceAnnotations[0]["surpriseLikelihood"])"
                    let angry = "\(faceAnnotations[0]["angerLikelihood"])"
                    let joyful = "\(faceAnnotations[0]["joyLikelihood"])"
                    let sad = "\(faceAnnotations[0]["sorrowLikelihood"])"
                    
                    self.labelResults.text = "Surprise: \(surprise), Angry: \(angry), Joyful: \(joyful), Sad: \(sad)"
                    
                    
                } else {
                    self.faceResults.text = "No faces found"
                }
            }
        })
}

    extension ViewController {
        func base64EncodeImage(_ image: UIImage) -> String {
            var imagedata = UIImagePNGRepresentation(image)
            
            // Resize the image if it exceeds the 2MB API limit
            if (imagedata?.count > 2097152) {
                let oldSize: CGSize = image.size
                let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
                imagedata = resizeImage(newSize, image: image)
            }
            
            return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
        }
        
        func createRequest(with imageBase64: String) {
            // Create our request URL
            
            var request = URLRequest(url: googleURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            
            // Build our API request
            let jsonRequest = [
                "requests": [
                    "image": [
                        "content": imageBase64
                    ],
                    "features": [
                        [
                            "type": "LABEL_DETECTION",
                            "maxResults": 10
                        ],
                        [
                            "type": "FACE_DETECTION",
                            "maxResults": 10
                        ]
                    ]
                ]
            ]
            let jsonObject = JSON(jsonDictionary: jsonRequest)
            guard let data = try? jsonObject.rawData() else {
                return
            }
            request.httpBody = data
            DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
        }
        
        func runRequestOnBackgroundThread(_ request: URLRequest) {
            
            let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                self.analyzeResults(data)
            }
            
            task.resume()
        }
    }
    
    
    // FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
    // Consider refactoring the code to use the non-optional operators.
    fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l < r
        case (nil, _?):
            return true
        default:
            return false
        }
    }
    
    // FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
    // Consider refactoring the code to use the non-optional operators.
    fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l > r
        default:
            return rhs < lhs
        }
}
