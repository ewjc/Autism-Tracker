//
//  ViewController.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class UpdateChildStatusView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let eventArray = ["userArrivedHome", "userLeftHome", "userIsIdleAtHome", "userStartedWalking", "userStartedRunning", "userStartedSleeping", "userWokeUp", "dailySummary"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for index in 0..<eventArray.count {
//            let newSubscription = NSubscription(eventName: eventArray[index],
//                                                identifier: "subscription unique identifier",
//                                                webhookId: "UpdateStatus")
//            NeuraSDK.shared.add(newSubscription) { result in
//            }
//        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
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

