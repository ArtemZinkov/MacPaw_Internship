//
//  GetCurrentYear.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentYear() -> Int {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        
        if let year = Int(dateFormatter.string(from: currentDate)) {
            return year
        } else {
            return 1970
        }
    }
}
