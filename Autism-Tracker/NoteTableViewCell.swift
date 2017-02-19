//
//  EventTableViewCell.swift
//  Autism-Tracker
//
//  Created by Nicholas Swift on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    @IBOutlet weak var activityLevelLabel: UILabel!
    @IBOutlet weak var selfHarmLevelLabel: UILabel!
    @IBOutlet weak var stressLevelLabel: UILabel!
    @IBOutlet weak var moodLevelLabel: UILabel!
    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
