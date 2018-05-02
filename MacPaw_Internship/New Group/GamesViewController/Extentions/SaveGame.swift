//
//  SaveGame.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import CoreData
import UIKit

extension GamesViewController {
    func save(from gameView: AddingGameView) {        
        let gameParameters = (
            title: gameView.title.text ?? "",
            gameDescription: gameView.gameDescription.text ?? "",
            genre: Constants.genres[gameView.genrePicker.selectedRow(inComponent: 0)],
            year: years[gameView.datePicker.selectedRow(inComponent: 0)],
            pathToPoster: gameView.poster.image?.save() ?? ""
        )
        if let game = LocalNetworkDB.saveGame(gameParameters: gameParameters) {
            fetchedGames.append(game)
        }
    }
}
