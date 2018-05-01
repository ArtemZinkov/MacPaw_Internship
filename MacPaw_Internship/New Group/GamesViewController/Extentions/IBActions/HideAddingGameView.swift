//
//  HideAddingGameView.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController {
    func hideAddingGameView() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let weakSelf = self {
                weakSelf.effect = weakSelf.visualBlur.effect
                weakSelf.visualBlur.effect = nil
                weakSelf.addGameView.alpha = 0.0
            }
        }) { [weak self] (success) in
            if let weakSelf = self {
                weakSelf.view.bringSubview(toFront: weakSelf.tableView)
                weakSelf.addGameView.clearView()
            }
        }
        save(from: addGameView)
    }
}
