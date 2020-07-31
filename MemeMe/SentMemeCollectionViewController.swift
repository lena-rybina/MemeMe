//
//  SentMemeCollectionViewController.swift
//  Mememe
//
//  Created by Ielena Rybina on 7/10/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    var memes: [Meme] { GlobalConfig.singleton.memeList }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 2.0
        let width = (view.frame.size.width - space) / 3
        let height = width
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width,
                                     height: height)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell",
                                                      for: indexPath) as! SentMemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.sentMemeView.image = meme.memedImage
        
        return cell
    }
}
