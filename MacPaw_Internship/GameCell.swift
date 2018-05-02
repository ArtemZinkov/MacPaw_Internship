//
//  gameCell.swift
//  MacPaw_Internship
//
//  Created by Artem on 23.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var genre: UITextView!
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var poster: UIImageView!

    func fillCell(with object: Game) {

        if let titleText = object.title {
            if let year = object.year, year != "" {
                title.text = titleText + " (\(year))"
            } else {
                title.text = titleText
            }
        }
 
        gameDescription.text = object.gameDescription
        genre.text = object.genre
        if let uniqueKey = object.pathToPoster {
            poster.image = getImage(by: uniqueKey)
        }
    }
    
    private func getImage(by uniqueKey: String) -> UIImage? {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        do {
            let data = try Data(contentsOf: documentsUrl.appendingPathComponent(uniqueKey))
            return UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
