//
//  IBActions.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController {
    func showAddingGameView() {
        addGameView.clearView()
        view.bringSubview(toFront: visualBlur)
        view.bringSubview(toFront: addGameView)
        addGameView.center = visualBlur.center
        UIView.animate(withDuration: 0.5) { [weak self] in
            if let weakSelf = self {
                weakSelf.visualBlur.effect = weakSelf.effect
                weakSelf.addGameView.alpha = 0.75
            }
        }
    }
}
