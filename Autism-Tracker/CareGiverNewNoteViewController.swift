//
//  CareGiverNewNoteViewController.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class CareGiverNewNoteViewController: UIViewController {
    
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
