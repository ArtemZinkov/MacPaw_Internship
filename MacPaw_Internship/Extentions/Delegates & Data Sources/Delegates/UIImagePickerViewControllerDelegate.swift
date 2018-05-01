//
//  GamesViewController+UIImagePickerViewControllerDelegate.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addGameView.pathToPoster = (info[UIImagePickerControllerImageURL] as! URL).path
        addGameView.poster.alpha = 1.0
        addGameView.poster.image = UIImage(contentsOfFile: addGameView.pathToPoster)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
