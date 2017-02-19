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
//  @IBOutlet weak
    @IBOutlet weak var dateLabel: UILabel!
    
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
