//
//  File.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
