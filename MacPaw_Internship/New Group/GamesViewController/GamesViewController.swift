//
//  ViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal var filteredGames = [Game]() { didSet{ tableView.reloadData() } }
    internal var fetchedGames = [Game]() { didSet { filteredGames = fetchedGames.filter { filterGame($0) } } }
    internal var effect: UIVisualEffect!
    internal var searchController: UISearchController!
    internal var years = [String]()

    internal let imagePicker = UIImagePickerController()
    
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
        setupGamesViewController()
    }
    
    private func setupGamesViewController() {
        imagePicker.delegate = self
        
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
        fetchedGames = LocalNetworkDB.fetchGames()
    }

    func presetSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = Constants.filterCategories
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    @objc func doneAction() {
        navigationItem.searchController?.searchBar.endEditing(true)
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
