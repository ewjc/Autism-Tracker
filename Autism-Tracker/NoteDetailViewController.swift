//
//  NoteDetailViewController.swift
//  Autism-Tracker
//
//  Created by Alexander Dejeu on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

  var theNote : Note!
  @IBOutlet weak var theTableView : UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      theTableView.tableFooterView = UIView()
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    theTableView.reloadData()
  }

}

extension NoteDetailViewController : UITableViewDelegate{
  
}

extension NoteDetailViewController : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteDetailViewCell") as! NoteDetailViewCell
    
    cell.resolutionLabel.text = "Resolution : \(theNote.resolution!)"
    cell.triggerLabel.text = "Trigger : \(theNote.trigger!)"
    cell.notesLabel.text = "Notes : \(theNote.additionalNotes!)"
    print(theNote.mood)
    let emoji = convertMoodTextToEmoji(text: theNote.mood)
    cell.moodLabel.text = "Mood : \(emoji) \(theNote.mood!) \(emoji)"
    
    cell.activityLevel.addPopulatedData(tag: 0, min: 0, max: 10, data: theNote.physicalActivityLevel!)
    cell.selfHarmLevel.addPopulatedData(tag: 1, min: 0, max: 10, data: theNote.selfHarmLevel!)
    cell.stressLevel.addPopulatedData(tag: 2, min: 0, max: 10, data: theNote.stressLevel!)

    
    
    return cell
  }
  
  func convertMoodTextToEmoji(text: String) -> String{
    switch text{
      case "Happy":
        return "😁"
      case "Shocked":
        return "😲"
      case "Neutral":
        return "😐"
      case "Angry":
        return "😠"
      case "Sad":
        return "😢"
    default:
      return ""
    }
  }
}
