//
//  GlobalConfig.swift
//  Mememe
//
//  Created by Elena Rybina on 7/30/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit
import Foundation

class GlobalConfig {
    static let singleton: GlobalConfig = GlobalConfig()
    var memeList: [Meme] = [Meme(topText: "Lena",
                                 bottomText: "Is Cool",
                                 originalImage: UIImage(named: "meme")!,
                                 memedImage: UIImage(named: "meme")!),
                            Meme(topText: "Lena",
                                 bottomText: "Is Cool 2",
                                 originalImage: UIImage(named: "meme")!,
                                 memedImage: UIImage(named: "meme")!),
                            Meme(topText: "Lena",
                                 bottomText: "Is Cool 3",
                                 originalImage: UIImage(named: "meme")!,
                                 memedImage: UIImage(named: "meme")!),
                            Meme(topText: "Lena",
                                 bottomText: "Is Cool 4",
                                 originalImage: UIImage(named: "meme")!,
                                 memedImage: UIImage(named: "meme")!)
    ]
}
