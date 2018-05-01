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
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: container.viewContext) as! Game
        
        game.gameDescription = gameView.gameDescription.text
        game.title = gameView.title.text
        game.genre = Constants.genres[gameView.genrePicker.selectedRow(inComponent: 0)]
        game.year = years[gameView.datePicker.selectedRow(inComponent: 0)]
        game.pathToPoster = gameView.poster.image?.save()
        do {
            try container.viewContext.save()
            fetchedGames.append(game)
        } catch {
            print(error.localizedDescription)
        }
    }
}
