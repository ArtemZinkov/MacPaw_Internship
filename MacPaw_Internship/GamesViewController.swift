//
//  ViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit
import CoreData

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var effect: UIVisualEffect!
    private lazy var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private lazy var frc = (UIApplication.shared.delegate as! AppDelegate).fetchedResultController
    private var fetchedGames = [Game]() { didSet { tableView.reloadData() } }
    
    private let cellIdentifier = "gameCell"
    private let genres = ["RPG", "Action", "Strategy", "Simulator"]
    private let imagePicker = UIImagePickerController()

    @IBOutlet weak var addGameView: AddingGameView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var visualBlur: UIVisualEffectView!
    
    @IBAction func addingGame(_ sender: UIBarButtonItem) {
        addGameView.clearView()
        view.bringSubview(toFront: addGameView)
        addGameView.center = visualBlur.center
        UIView.animate(withDuration: 0.5) { [weak self] in
            if let weakSelf = self {
                weakSelf.visualBlur.effect = weakSelf.effect
                weakSelf.addGameView.alpha = 1.0
            }
        }
    }
    
    func presetAddGameView() {
        view.addSubview(addGameView)
        addGameView.alpha = 0
        addGameView.layer.cornerRadius = 5.0
        addGameView.gameDescription.layer.cornerRadius = 5.0
        addGameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if addGameView.poster.frame.contains(sender.location(in: addGameView)) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func hideAddGameView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            if let weakSelf = self {
                weakSelf.visualBlur.effect = nil
                weakSelf.addGameView.alpha = 0.0
            }
        }
        view.bringSubview(toFront: tableView)
        save(from: addGameView)
        addGameView.clearView()
    }
    
    private func save(from gameView: AddingGameView) {
        let backgroundContext = container.newBackgroundContext()
        let game = NSEntityDescription.insertNewObject(forEntityName: "Game", into: backgroundContext) as! Game
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"

        game.gameDescription = gameView.gameDescription.text
        game.title = gameView.title.text
        game.pathToPoster = gameView.pathToPoster
        game.genre = gameView.choosedGenre
        game.year = dateFormatter.string(from: gameView.datePicker.date)
        fetchedGames.append(game)
        backgroundContext.insert(game)
        do {
            try backgroundContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        presetAddGameView()
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
    
    // Delegate Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GameCell {
            if fetchedGames.count >= indexPath.row + 1 {
                cell.fillCell(with: fetchedGames[indexPath.row])
            }
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedGames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addGameView.choosedGenre = genres[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addGameView.pathToPoster = (info[UIImagePickerControllerImageURL] as! URL).path
        addGameView.poster.alpha = 1.0
        addGameView.poster.image = UIImage(contentsOfFile: addGameView.pathToPoster)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        addGameView.poster.image = #imageLiteral(resourceName: "addImage")
        addGameView.poster.alpha = 0.5
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
