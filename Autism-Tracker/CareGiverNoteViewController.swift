////
////  CareGiverNoteViewController.swift
////  Autism-Tracker
////
////  Created by Nicholas Swift on 2/18/17.
////  Copyright © 2017 Tawpy. All rights reserved.
////
//
//import UIKit
//
//class CareGiverNoteViewController: UITableViewController {
//    
//    // MARK: - Instance Vars
//    var photoTakingHelper: PhotoTakingHelper?
//    let dateFunc = Date()
//    let calendar = Calendar.current
//    let formatter = DateFormatter()
//    
//    // MARK: - Subviews
//    @IBOutlet weak var stressSlider: UISlider!
//    @IBOutlet weak var activityLevelSlider: UISlider!
//    @IBOutlet weak var selfHarmSlider: UISlider!
//    @IBOutlet weak var triggerTextField: UITextField!
//    @IBOutlet weak var resolutionTextField: UITextField!
//    @IBOutlet weak var additionalNotesTextField: UITextField!
//    @IBOutlet weak var photoImage: UIImageView!
//    
//    
//    // MARK: - Subview Actions
//    @IBAction func cancelBarButtonAction(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
//    }
//    @IBAction func addPhotoBtnTapped(_ sender: Any) {
//        print("Add image button tapped")
//        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
//            self.photoImage.image = image!
//        }
//    }
//    
//    @IBAction func trackEventBtnTapped(_ sender: Any) {
//        
//        let note = Note()
//        note.mood = "happy"
//        note.photo = photoImage.image
//        note.physicalActivityLevel = Int(activityLevelSlider.value)
//        note.trigger = triggerTextField.text
//        note.resolution = resolutionTextField.text
//        note.stressLevel = Int(stressSlider.value)
//        note.additionalNotes = additionalNotesTextField.text
//        
//        let alertMessage = "Your behavior has successfully been tracked!"
//        let alert = UIAlertController(title: "Succes", message: alertMessage, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //MARK: DATE
//        formatter.dateFormat = "MM/dd/yyyy"
//        let result = formatter.string(from: dateFunc)
//        
//        var components = calendar.dateComponents([.hour, .minute], from: dateFunc)
//        if components.hour! > 12 {
//            components.hour = components.hour! - 12
//        }
//        //        dateLabel.text = ("Date: \(result) at \(components.hour!):\(components.minute!)")
//        
//    }
//}
