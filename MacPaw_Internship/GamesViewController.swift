//
//  ViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit
import CoreData

class GamesViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    lazy var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    lazy var frc = (UIApplication.shared.delegate as! AppDelegate).fetchedResultController
    
    var filteredGames = [Game]() { didSet{ tableView.reloadData() } }
    var fetchedGames = [Game]() { didSet { filteredGames = fetchedGames.filter { filterGame($0) } } }
    var effect: UIVisualEffect!
    var searchController: UISearchController!
    var years = [String]()

    let cellIdentifier = "gameCell"
    let genres = ["RPG", "Action", "Strategy", "Simulator"]
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var addGameView: AddingGameView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var visualBlur: UIVisualEffectView!
    
    @IBAction func addingGame(_ sender: UIBarButtonItem) {
        showAddingGameView()
    }
    
    @IBAction func hideAddGameView(_ sender: UIButton) {
        hideAddingGameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let currentYear = Date.getCurrentYear()
        for year in 1970...currentYear {
            years.append(String(year))
        }
        years.reverse()
        
        presetSearchController()
        view.addSubview(addGameView)
        addGameView.delegate = self
        addGameView.preset()
        
        effect = visualBlur.effect
        visualBlur.effect = nil
        do {
            try frc.performFetch()
            if let tempValue = frc.fetchedObjects {
                fetchedGames = tempValue
            } else {
                fetchedGames = []
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if addGameView.poster.frame.contains(sender.location(in: addGameView)) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func presetSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Title", "Year", "Description", "Genre"]
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    // Delegate Functions
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredGames = fetchedGames.filter { filterGame($0) }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredGames = fetchedGames.filter { filterGame($0) }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filteredGames = fetchedGames.filter { filterGame($0) }
    }
}
