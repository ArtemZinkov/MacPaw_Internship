//
//  LocalNetworkDB.swift
//  MacPaw_Internship
//
//  Created by Artem on 02.05.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit
import CoreData

class LocalNetworkDB {
    private static var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private static var frc = (UIApplication.shared.delegate as! AppDelegate).fetchedResultController
    
    static func getImage(by uniqueKey: String) -> UIImage? {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        do {
            let data = try Data(contentsOf: documentsUrl.appendingPathComponent(uniqueKey))
            return UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func fetchGames() -> [Game] {
        do {
            try frc.performFetch()
            if let fetchedGames = frc.fetchedObjects {
                return fetchedGames
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    static func saveGame(gameParameters: (title: String, gameDescription: String, year: String, genre: String, pathToPoster: String)) -> Game? {
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: container.viewContext) as! Game
        
        game.gameDescription = gameParameters.gameDescription
        game.title = gameParameters.title
        game.genre = gameParameters.genre
        game.year = gameParameters.year
        game.pathToPoster = gameParameters.pathToPoster

        do {
            try container.viewContext.save()
            return game
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
