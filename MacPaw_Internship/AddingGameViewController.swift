//
//  AddingGameViewController.swift
//  MacPaw_Internship
//
//  Created by Artem on 26.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

class AddingGameViewController: UIViewController {

    @IBOutlet weak var addingGameView: AddingGameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingGameView.setDelegatesToTextViews()
    }

}
