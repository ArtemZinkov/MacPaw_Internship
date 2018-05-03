//
//  ViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Protected variables
    private var filteredGamesProtected = [Game]() { didSet{ tableView.reloadData() } }
    private var fetchedGamesProtected = [Game]() { didSet { filteredGamesProtected = fetchedGamesProtected.filter { filterGame($0) } } }
    private var effectProtected: UIVisualEffect!
    private var searchControllerProtected: UISearchController!
    private let imagePickerProtected = UIImagePickerController()
    private var yearsProtected = [String]()

    // Public Read-Only access to private variables
    public var years: [String] { return yearsProtected }
    public var searchController: UISearchController!{ return searchControllerProtected }
    public var imagePicker: UIImagePickerController { return imagePickerProtected }
    public var filteredGames: [Game] { return filteredGamesProtected }
    public var fetchedGames: [Game] { return fetchedGamesProtected }
    public var effect: UIVisualEffect! { return effectProtected }

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
            yearsProtected.append(String(year))
        }
        yearsProtected.reverse()
        
        presetSearchController()
        view.addSubview(addGameView)
        addGameView.delegate = self
        addGameView.preset()
        
        effectProtected = visualBlur.effect
        visualBlur.effect = nil
        fetchedGamesProtected = LocalNetworkDB.fetchGames()
    }

    private func presetSearchController() {
        searchControllerProtected = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = Constants.filterCategories
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    func appendToGamelist(new game: Game) {
        fetchedGamesProtected.append(game)
    }
    
    func deblurView() {
        effectProtected = visualBlur.effect
       visualBlur.effect = nil
    }
    
    @objc func doneAction() {
        navigationItem.searchController?.searchBar.endEditing(true)
    }
    
    // Delegate Functions
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteredGamesProtected = fetchedGames.filter { filterGame($0) }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredGamesProtected = fetchedGames.filter { filterGame($0) }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filteredGamesProtected = fetchedGames.filter { filterGame($0) }
    }
}
