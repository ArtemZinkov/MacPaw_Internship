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
        if let title = object.title {
            self.title.text = title
        }
        if let year = object.year {
            self.title.text = "(\(year))"
        }
        self.gameDescription.text = object.gameDescription
        self.genre.text = object.genre
        if let pathToPoster = object.pathToPoster {
            self.poster.image = UIImage(contentsOfFile: pathToPoster)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
