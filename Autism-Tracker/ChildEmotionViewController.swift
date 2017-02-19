//
//  ChildEmotionViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class ChildEmotionViewController: UIViewController {
    
    // MARK: - Instance Vars
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: - Google Stuff
    let session = URLSession.shared
    var googleAPIKey = "AIzaSyAKry8rIJ9LnJLFihe6yyVmM-u_1y4FUrg"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    // MARK: - Subviews
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Subview Actions
    @IBAction func backBarAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func takePhotoAction(_ sender: Any) {
        getPhoto()
    }
    @IBAction func redoAction(_ sender: Any) {
        pictureImageView.image = nil
        takePhotoButton.isHidden = false
        bodyLabel.text = "Take a photo of someone to determine his or her emtion"
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureImageView.clipsToBounds = true
        
    }
    
}

// MARK: - Google Emotions
extension ChildEmotionViewController {
    
    func getPhoto() {
        
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            if let image = image {
                
                self.pictureImageView.image = image
                self.takePhotoButton.isHidden = true
                
                let base64image = self.base64EncodeImage(image)
                self.createRequest(with: base64image)
            }
        }
        
    }
    
}


// Google API Image Recognition
extension ChildEmotionViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        DispatchQueue.main.async(execute: {
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            // Error
            if errorObj.dictionaryValue != [:] {
                print("Error has occured")
                return
            }
            
            // Responses and face annotations
            let responses: JSON = json["responses"][0]
            let faceAnnotations: JSON = responses["faceAnnotations"]
            
            // No faces
            if faceAnnotations == JSON.null {
                print("No faces found")
                return
            }
            
            let emotions: [String] = ["joy", "sorrow", "surprise", "anger"]
            let numPeopleDetected: Int = faceAnnotations.count
            
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
            }
            
            let surprise = "\(faceAnnotations[0]["surpriseLikelihood"])"
            let angry = "\(faceAnnotations[0]["angerLikelihood"])"
            let joyful = "\(faceAnnotations[0]["joyLikelihood"])"
            let sad = "\(faceAnnotations[0]["sorrowLikelihood"])"
            
            print("FINALLY DOING SOMETHING HERE")
            print("Surprise: \(surprise), Angry: \(angry), Joyful: \(joyful), Sad: \(sad)")
            
            self.bodyLabel.text = "Surprise: \(surprise), Angry: \(angry), Joyful: \(joyful), Sad: \(sad)"
            
        })
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
    
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if ((imagedata?.count)! > 2097152) {
            let newImage = resizeImage(image: image, newWidth: 800)
            imagedata = UIImagePNGRepresentation(newImage)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}



//// MARK: - Photo Taking
//extension ChildEmotionViewController {
//    
//    func getPhoto() {
//        
//        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
//            if let image = image {
//                
//                self.pictureImageView.image = image
//                
//                // Create url and reference
//                let url = "\(Date()).jpg"
//                let storageRef: FIRStorageReference = FIRStorage.storage().reference().child("Images/\(url)")
//                
//                // Turn image into data
//                guard let imageData = UIImageJPEGRepresentation(image, 1) else {
//                    let error = NSError(domain: "Error occured when trying to turn image into data", code: 400, userInfo: nil)
//                    return
//                }
//                
//                // Upload image to firebase
//                storageRef.put(imageData, metadata: nil) { (metadata: FIRStorageMetadata?, error: Swift.Error?) in
//                    if error != nil {
//                        return
//                    }
//                    
//                    let downloadURL = metadata!.downloadURL()!.absoluteString
//                    self.getEmotion(imageURL: downloadURL)
//                }
//                
//            }
//        }
//    }
//    
//}
//
//// MARK: - Emotions
//extension ChildEmotionViewController {
//    
//    func getEmotion(imageURL: String) {
//        MicrosoftService.getEmotion(imageURL: imageURL) { [weak self] (text: String) in
//            
//            // Set body label
//            self?.bodyLabel.text = text
//            
//            // Change take photo text
//            self?.takePhotoButton.isHidden = true
//        }
//    }
//    
//}
