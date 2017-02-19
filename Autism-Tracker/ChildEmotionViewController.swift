//
//  ChildEmotionViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

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
        
    }
    
}

// MARK: - Photo Taking
extension ChildEmotionViewController {
    
    func getPhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            if let image = image {
                self.getEmotion(imageData: UIImageJPEGRepresentation(image, 1)!)
            }
        }
    }
    
}

// MARK: - Emotions
extension ChildEmotionViewController {
    
    func getEmotion(imageData: Data) {
        MicrosoftService.getEmotion(imageData: imageData) { [weak self] (text: String) in
            
            // Set body label
            self?.bodyLabel.text = text
            
            // Change take photo text
            self?.takePhotoButton.isHidden = true
        }
    }
    
}
