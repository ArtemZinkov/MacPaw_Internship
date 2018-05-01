//
//  SaveImage.swift
//  MacPaw_Internship
//
//  Created by Artem on 30.04.2018.
//  Copyright © 2018 Artem. All rights reserved.
//

import UIKit

extension UIImage {
    func save(for uniqueKey: String) -> String? {
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        
        if !fileManager.fileExists(atPath: documentsUrl.relativePath!) {
            do {
                try FileManager.default.createDirectory(atPath: documentsUrl.relativePath!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let fileURL = documentsUrl.appendingPathComponent(uniqueKey)
        if let imageData = UIImageJPEGRepresentation(self, 1.0) {
            do {
                try imageData.write(to: fileURL!, options: .atomic)
                return fileURL?.path
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
