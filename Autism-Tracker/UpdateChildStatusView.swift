//
//  ViewController.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit
import NeuraSDK


class UpdateChildStatusView: UIViewController {
    
    // MARK: - Instance Vars
    var authToken: String = ""
    let eventArray = ["userArrivedHome", "userLeftHome", "userIsIdleAtHome", "userStartedWalking", "userStartedRunning", "userStartedSleeping", "userWokeUp", "dailySummary"]
    
    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNeura()
    }
    
}

// MARK: - Neura Events
extension UpdateChildStatusView {
    
    func setupNeura() {
        setupNeuraAuth()
        setupNeuraEvents()
        setupNeuraGetEvents()
    }
    
    func setupNeuraAuth() {
        
        // Authentication request
        let authRequest = NeuraAuthenticationRequest(controller: self)
        
        // Authenticate.
        NeuraSDK.shared.authenticate(with: authRequest) { result in
            if result.success {
                // Success. result.token available
                self.authToken = result.token!
            } else {
                // Failed. An error description available on result.error
            }
        }
    }
    
    func setupNeuraEvents() {
        
        // Create indexes
        for event in eventArray {
            
            // Create new subscription
            let newSubscription = NSubscription(eventName: event, identifier: "\(event.hashValue)", webhookId: "UpdateStatus")
            
            // Add subscription
            NeuraSDK.shared.add(newSubscription, callback: { (result: NeuraAddSubscriptionResult) in
                print(result)
            })
        }
    }
    
    func setupNeuraGetEvents() {
        // Get the subscriptions list
        NeuraSDK.shared.getSubscriptionsList() { result in
            if result.success {
                print(result.subscriptions)
            }
        }
    }
}

// MARK: - Table View
extension UpdateChildStatusView {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

// MARK: - Table View Delegate
extension UpdateChildStatusView: UITableViewDelegate {
    
}

// MARK: - Table View Data Source
extension UpdateChildStatusView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UpdateStatusTVC
        
        cell.statusLabel.text = ""
        cell.dateLabel.text = ""
        
        return cell
    }
    
}

