//
//  DataSource.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? GameCell {
            if filteredGames.count >= indexPath.row + 1 {
                cell.fillCell(with: filteredGames[indexPath.row])
            }
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
}
