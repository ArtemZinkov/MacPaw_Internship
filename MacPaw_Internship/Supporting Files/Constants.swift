//
//  Constants.swift
//  MacPaw_Internship
//
//  Created by Artem on 01.05.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

class Constants {
    public static let genres = ["RPG", "Action", "Strategy", "Simulator"]
    public static let filterCategories = ["Title", "Year", "Description", "Genre"]
    public static let cellIdentifier = "gameCell"
    
    public enum Genres {
        case RPG
        case Action
        case Strategy
        case Simulator
    }
    
    public enum FilterCategories {
        case Title
        case Year
        case Description
        case Genre
    }
}
