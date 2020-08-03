//
//  MemeModel.swift
//  MemeMe v2.0
//
//  Created by Elena Rybina on 6/10/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import Foundation
import UIKit

struct Meme: Codable {
    var memeId: String
    
    let topText : String
    let bottomText : String
    
    var memedImage: UIImage? {
        guard let filePath = SavingManager.generateFilePath(forKey: memeId),
            let fileData = FileManager.default.contents(atPath: filePath.path) else { return nil }
        
        return UIImage(data: fileData)
    }
}
