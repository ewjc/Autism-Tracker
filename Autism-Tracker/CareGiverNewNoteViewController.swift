//
//  CareGiverNewNoteViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class CareGiverNewNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  //MARK: - IBOutlets
  @IBOutlet weak var triggerTextField : UITextField!
  @IBOutlet weak var resolutionTextField : UITextField!
  @IBOutlet weak var notesTextArea : UITextView!
  @IBOutlet weak var happyButton : UIButton!
  @IBOutlet weak var shockedButton : UIButton!
  @IBOutlet weak var neutralButton : UIButton!
  @IBOutlet weak var angryButton : UIButton!
  @IBOutlet weak var sadButton : UIButton!
  
  @IBOutlet weak var activityLevel : customDragView!
  @IBOutlet weak var selfHarmLevel : customDragView!
  @IBOutlet weak var stressLevel : customDragView!
  
  @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
  
  
  //MARK: - IBActions
  @IBAction func saveNote(sender: UIButton){
    print("SAVE THE NOTE")
        print("activity \(activityLevel.getCurrentValue())")
        print("self harm \(selfHarmLevel.getCurrentValue())")
        print("Stress \(stressLevel.getCurrentValue())")
        
        sendToServer()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapMoodButton(sender : UIButton){
        print("Yeah we tapped a mood")
        happyButton.backgroundColor = .clear
        shockedButton.backgroundColor = .clear
        neutralButton.backgroundColor = .clear
        angryButton.backgroundColor = .clear
        sadButton.backgroundColor = .clear
        
        switch sender.tag{
        case 0:
            selectedMood = "Happy"
            happyButton.backgroundColor = UIColor.brandBlue
        case 1:
            selectedMood = "Shocked"
            shockedButton.backgroundColor = UIColor.brandBlue
        case 2:
            selectedMood = "Neutral"
            neutralButton.backgroundColor = UIColor.brandBlue
        case 3:
            selectedMood = "Angry"
            angryButton.backgroundColor = UIColor.brandBlue
        case 4:
            selectedMood = "Sad"
            sadButton.backgroundColor = UIColor.brandBlue
        default:
            print("Yikes")
        }
    }
  
  
  // MARK: - Instance Vars
  var selectedMood = ""
  
  // MARK: - Subviews
  @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
  
  // MARK: - Subview Actions
  @IBAction func cancelBarButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup Scrollview
    mainScrollView.isDirectionalLockEnabled = true
    mainScrollView.contentSize = CGSize(width: view.bounds.width, height: mainScrollView.contentSize.height)
    
    // Alex set up everything else
    cleanupUI()
    happyButton.tag = 0
    shockedButton.tag = 1
    neutralButton.tag = 2
    angryButton.tag = 3
    sadButton.tag = 4
    triggerTextField.delegate = self
    resolutionTextField.delegate = self
    notesTextArea.delegate = self

    activityLevel.addData(tag:  0, min: 0, max: 10.0)
    stressLevel.addData(tag:  1, min: 0, max: 10.0)
    selfHarmLevel.addData(tag:  2, min: 0, max: 10.0)
    
  }
  
  
  //MARK: - Close keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Delegate method
    // Called when 'return' key pressed. return NO to ignore.
    textField.resignFirstResponder()
    return true
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if (text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }

    // MARK: - Helpers
    func cleanupUI(){
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        happyButton.titleLabel?.textAlignment = .center
        shockedButton.titleLabel?.textAlignment = .center
        neutralButton.titleLabel?.textAlignment = .center
        angryButton.titleLabel?.textAlignment = .center
        sadButton.titleLabel?.textAlignment = .center
      
      happyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
      happyButton.titleLabel?.minimumScaleFactor = 0.5
      happyButton.titleLabel?.lineBreakMode = .byWordWrapping
      happyButton.layer.cornerRadius = happyButton.frame.width / 2.0
      
      shockedButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
      shockedButton.titleLabel?.minimumScaleFactor = 0.5
      shockedButton.titleLabel?.lineBreakMode = .byWordWrapping
      shockedButton.layer.cornerRadius = shockedButton.frame.width / 2.0
      
      neutralButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
      neutralButton.titleLabel?.minimumScaleFactor = 0.5
      neutralButton.titleLabel?.lineBreakMode = .byWordWrapping
      neutralButton.layer.cornerRadius = neutralButton.frame.width / 2.0
      
      angryButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
      angryButton.titleLabel?.minimumScaleFactor = 0.5
      angryButton.titleLabel?.lineBreakMode = .byWordWrapping
      angryButton.layer.cornerRadius = angryButton.frame.width / 2.0
      
      sadButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
      sadButton.titleLabel?.minimumScaleFactor = 0.5
      sadButton.titleLabel?.lineBreakMode = .byWordWrapping
      sadButton.layer.cornerRadius = sadButton.frame.width / 2.0
      
    }
    
}

// MARK: - Server
extension CareGiverNewNoteViewController {
    
    func sendToServer() {
        
        let mood = selectedMood
        let stress = Int(stressLevel.getCurrentValue())
        let physicalActivity = Int(activityLevel.getCurrentValue())
        let selfHarm = Int(selfHarmLevel.getCurrentValue())
        let trigger = triggerTextField.text ?? "No trigger provided"
        let resolution = resolutionTextField.text ?? "No resolution provided"
        let notes = notesTextArea.text ?? "No notes provided"
        let photo = UIImage()
        let time = "Friday"
        
        let note = Note(mood: mood, stressLevel: stress, physicalActivityLevel: physicalActivity, selfHarmLevel: selfHarm, trigger: trigger, resolution: resolution, additionalNotes: notes, photo: photo, time: time)
        
        NoteService.createNote(note: note) { (returnedNote: Note?, error: Error?) in
            // Has sent to server
        }
        
    }
    
}
