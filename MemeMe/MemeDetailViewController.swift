//
//  DetailMeme.swift
//  MemeMe
//
//  Created by Elena Rybina on 7/31/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {

    var meme : Meme!
 @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
        
    self.imageView!.image = meme.memedImage
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

