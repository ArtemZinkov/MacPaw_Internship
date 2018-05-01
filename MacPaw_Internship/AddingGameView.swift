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
    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var datePicker: UIPickerView!
    
    var pathToPoster = ""
    
    var delegate: GamesViewController!
 
    func clearView() {
        title.text = ""
        gameDescription.text = ""
        poster.image = #imageLiteral(resourceName: "addImage")
        poster.alpha = 0.5
        pathToPoster = ""
        genrePicker.selectRow(0, inComponent: 0, animated: true)
        datePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    func preset() {
        alpha = 0
        layer.cornerRadius = 5.0
        gameDescription.layer.cornerRadius = 5.0
        let tap = UITapGestureRecognizer(target: delegate, action: #selector(delegate.handleTap(_:)))
        tap.delegate = delegate
        addGestureRecognizer(tap)
        if delegate.view.frame.width < frame.width {
            frame = CGRect(origin: frame.origin, size: CGSize(width: delegate.view.frame.width, height: frame.height))
        }
    }
}
