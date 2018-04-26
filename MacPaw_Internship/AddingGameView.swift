//
//  AddingGameCellView.swift
//  MacPaw_Internship
//
//  Created by Artem on 24.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class AddingGameView: UIView, UITextViewDelegate {

    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var genre: UITextView!
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var poster: UIImageView!
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Enter text here...") {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Enter text here..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }

    func setDelegatesToTextViews() {
        title.delegate = self
        genre.delegate = self
        gameDescription.delegate = self
    }
    
    @IBAction func finishAdding(_ sender: UIButton) {
        var a = 0
    }
    
}
