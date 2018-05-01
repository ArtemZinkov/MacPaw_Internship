//
//  GamesViewController+UIPickerViewDelegate+UIPickerViewDataSource.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension GamesViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addGameView.genrePicker {
            return Constants.genres[row]
        } else {
            return years[row]
        }
    }
}
