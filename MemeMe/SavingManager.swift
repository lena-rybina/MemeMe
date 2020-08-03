//
//  SavingManager.swift
//  MemeMe
//
//  Created by Elena Rybina on 8/2/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import Foundation

class SavingManager {
    static func generateFilePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
}
