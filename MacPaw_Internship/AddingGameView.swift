//
//  AddingGameCellView.swift
//  MacPaw_Internship
//
//  Created by Artem on 24.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class AddingGameView: UIView {

    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var genre: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var choosedGenre = ""
    var pathToPoster = ""
 
    func clearView() {
        title.text = ""
        gameDescription.text = ""
        poster.image = #imageLiteral(resourceName: "addImage")
        poster.alpha = 0.5
        choosedGenre = ""
        pathToPoster = ""
    }
}
