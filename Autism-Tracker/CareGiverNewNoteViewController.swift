//
//  CareGiverNewNoteViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class CareGiverNewNoteViewController: UIViewController {
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
  
  @IBAction func saveNote(sender: UIButton){
    print("SAVE THE NOTE")
    dismiss(animated: true, completion: nil)
  }
  
  
  // MARK: - Instance Vars
  
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
  }
  
}
