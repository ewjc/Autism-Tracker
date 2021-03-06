//
//  EventsView.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
  
  // MARK: - Instance Vars
  var notes: [Note] = []
  
  // MARK: - Subviews
  @IBOutlet weak var tableView: UITableView!
  var refreshControl = UIRefreshControl()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupRefreshControl()
    setupTableView()
    setupEvents()
  }
  
}

// MARK: - Events
extension NotesViewController {
  
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
extension NotesViewController {
  
  func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(setupEvents), for: .valueChanged)
  }
  
}

// MARK: - Table View
extension NotesViewController {
  
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
extension NotesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 10 : 5
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return section == tableView.numberOfSections - 1 ? 10: 5
  }
  
}

// MARK: - Table View Data Source
extension NotesViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
    return cell
  }
  
}
