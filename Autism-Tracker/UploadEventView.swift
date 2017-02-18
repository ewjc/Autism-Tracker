//
//  EventView.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class UploadEventView: UIViewController {
    
    // MARK : Properties
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK : IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stressSlider: UISlider!
    @IBOutlet weak var activityLevelSlider: UISlider!
    @IBOutlet weak var selfHarmSlider: UISlider!
    @IBOutlet weak var triggerTextField: UITextField!
    @IBOutlet weak var resolutionTextField: UITextField!
    @IBOutlet weak var additionalNotesTextField: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    // MARK : IBActions
    @IBAction func addPhotoBtnTapped(_ sender: Any) {
        print("Add image button tapped")
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            self.photoImage.image = image!
        }
    }
    
    @IBAction func trackEventBtnTapped(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }



}
