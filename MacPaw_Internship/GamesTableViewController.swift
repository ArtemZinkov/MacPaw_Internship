//
//  ViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {

    lazy var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    lazy var frc = (UIApplication.shared.delegate as! AppDelegate).fetchedResultController
    private let cellIdentifier = "gameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try frc.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GameCell {
            if frc.fetchedObjects!.count >= indexPath.row + 1 {
                cell.fillCell(with: frc.fetchedObjects![indexPath.row])
            }
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfCells = frc.fetchedObjects?.count {
            return numberOfCells
        } else {
            return 0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

