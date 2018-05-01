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
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let ratio = delegate.view.frame.width / frame.width * 0.9
        transform = CGAffineTransform(scaleX: ratio, y: ratio)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchedDot = sender.location(in: self)
        
        if poster.frame.contains(touchedDot) {
            delegate.imagePicker.sourceType = .photoLibrary
            delegate.present(delegate.imagePicker, animated: true, completion: nil)
        }
        if !gameDescription.frame.contains(touchedDot) && !poster.frame.contains(touchedDot) {
            endEditing(true)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            frame.origin.y -= keyboardSize.height
            frame.origin.y -= min(frame.origin.y, 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.origin.y != 0{
                center = delegate.view.center
            }
        }
    }
}
