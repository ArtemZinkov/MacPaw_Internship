//
//  FilterGame.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

extension GamesViewController {
    func filterGame(_ game: Game) -> Bool {
        
        var contains: Bool?
        let searchBarText = searchController.searchBar.text?.lowercased() ?? ""
        let filterCategory = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]

        switch filterCategory {
        case "Title":
            contains = game.title?.lowercased().contains(searchBarText)
        case "Year":
            contains = game.year?.lowercased().contains(searchBarText)
        case "Description":
            contains = game.gameDescription?.lowercased().contains(searchBarText)
        case "Genre":
            contains = game.genre?.lowercased().contains(searchBarText)
        default:
            return true
        }
        
        if let contains = contains {
            return contains || searchBarText.isEmpty || !searchController.isActive
        } else {
            return true
        }
    }
}
