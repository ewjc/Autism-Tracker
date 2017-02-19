//
//  ChildEmotionViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit
import Firebase

class ChildEmotionViewController: UIViewController {
    
    // MARK: - Instance Vars
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: - Subviews
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Subview Actions
    @IBAction func takePhotoAction(_ sender: Any) {
        getPhoto()
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
                self.getEmotion(base64EncodeImage(image))
            }
        }
        
    }
    
    func getEmotion(imageData: String) {
        
        GoogleService.getGoogleEmotion(imageData: imageData) { (string: String) in
            print("DO SHIT HERE PLEASE")
        }
        
    }
    
    // MARK: - Helpers
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
