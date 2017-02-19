//
//  ViewController.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Subviews
    @IBOutlet weak var careReceiverButton: UIButton!
    @IBOutlet weak var careGiverButton: UIButton!
    @IBOutlet weak var therapistParentButton: UIButton!
    
    // MARK: - Instance Vars
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupButtons() {
        
        for button in [careReceiverButton, careGiverButton, therapistParentButton] {
            button?.layer.borderColor = UIColor.brandBlue.cgColor
            button?.layer.borderWidth = 5
            button?.layer.cornerRadius = 5
            button?.clipsToBounds = true
        }
        
    }


}

