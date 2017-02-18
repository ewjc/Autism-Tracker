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
    let dateFunc = Date()
    let calendar = Calendar.current
    let formatter = DateFormatter()
    
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
        
        let event = Event()
        event.mood = "happy"
        event.time = dateLabel.text
        event.photo = photoImage.image
        event.physicalActivityLevel = Int(activityLevelSlider.value)
        event.trigger = triggerTextField.text
        event.resolution = resolutionTextField.text
        event.stressLevel = Int(stressSlider.value)
        event.additionalNotes = additionalNotesTextField.text
        
        EventService.createEvent(event: event) { (event: Event?, error: Error?) in
            //
        }
        
        let alertMessage = "Your behavior has successfully been tracked!"
        let alert = UIAlertController(title: "Succes", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: DATE
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: dateFunc)
        
        var components = calendar.dateComponents([.hour, .minute], from: dateFunc)
        if components.hour! > 12 {
            components.hour = components.hour! - 12
        }
        dateLabel.text = ("Date: \(result) at \(components.hour!):\(components.minute!)")
        
    }



}
