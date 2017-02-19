//
//  EventsView.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class CareGiverNotesViewController: UIViewController {
    
    // MARK: - Instance Vars
    var notes: [Note] = []
    var selectedIndex = -1
    
    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        setupTableView()
        setupEvents()
        styleSetup()
    }

  
    //MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SegueToNoteDetailView"{
      
      if let destinationVC = segue.destination as? NoteDetailViewController{
        destinationVC.theNote = notes[selectedIndex]
      }
    }
  }



}

// MARK: - Style
extension CareGiverNotesViewController {
    
    func styleSetup() {
        navigationController?.navigationBar.barTintColor = UIColor.brandBlue
        navigationController?.navigationBar.isTranslucent = false
        
        tabBarController?.tabBar.isTranslucent = false
    }
    
}

// MARK: - Events
extension CareGiverNotesViewController {
    
    func setupEvents() {
        
        NoteService.getAllNotes { [weak self] (notes: [Note]?, error: Error?) in
          
            // Error
            if let error = error {
                print("An error occured when trying to get events from server. \(error)")
                return
            }
            
            // If no events, return error
            guard let notes = notes else {
                print("An error occured when trying to get events from server.")
                return
            }
            
            // Set events
            self?.notes = notes
            
            // Reload table view and end refreshing
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        
    }
    
}

// MARK: - Refresh Control
extension CareGiverNotesViewController {
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(setupEvents), for: .valueChanged)
    }
    
}

// MARK: - Table View
extension CareGiverNotesViewController {
    
    func setupTableView() {
        
        // Add refresh control
        tableView.addSubview(refreshControl)
        
        // Register cells
        tableView.register(NoteTableViewCell.hsf_nib(), forCellReuseIdentifier: "NoteTableViewCell")
        
        // Set row height
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Style
        tableView.separatorColor = UIColor.clear
    }
    
}

// MARK: - Table View Delegate
extension CareGiverNotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableView.numberOfSections - 1 ? 10: 5
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.section
    self.performSegue(withIdentifier: "SegueToNoteDetailView", sender: nil)
  }
  
}

// MARK: - Table View Data Source
extension CareGiverNotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        let note = notes[indexPath.section]
        
        cell.triggerLabel.text = "Trigger: \(note.trigger!)"
        cell.resolutionLabel.text = "Resolution: \(note.resolution!)"
        
        cell.activityLevelLabel.text = "\(note.physicalActivityLevel!) / 10"
        cell.selfHarmLevelLabel.text = "\(note.selfHarmLevel!) / 10"
        cell.stressLevelLabel.text = "\(note.stressLevel!) / 10"
      cell.moodLevelLabel.text = "\(convertMoodTextToEmoji(text: note.mood!))"
        
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
