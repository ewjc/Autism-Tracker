//
//  NoteDetailViewCell.swift
//  Autism-Tracker
//
//  Created by Alexander Dejeu on 2/19/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class NoteDetailViewCell: UITableViewCell {

  @IBOutlet weak var triggerLabel : UILabel!
  @IBOutlet weak var resolutionLabel : UILabel!
  @IBOutlet weak var notesLabel : UILabel!
  @IBOutlet weak var dateLabel : UILabel!
  @IBOutlet weak var moodLabel : UILabel!
  @IBOutlet weak var activityLevel : customDragView!
  @IBOutlet weak var selfHarmLevel : customDragView!
  @IBOutlet weak var stressLevel : customDragView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
