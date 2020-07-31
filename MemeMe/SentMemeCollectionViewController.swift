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
    var memes: [Meme] = GlobalConfig.singleton.memeList
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var newMeme: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 2.0
        let width = (view.frame.size.width - 2 * space) / 3
        let height = width
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width,
                                     height: height)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.collectionViewLayout.invalidateLayout()
        
        GlobalConfig.singleton.subscribeOnChange({ memeList-> Void in
            self.memes = memeList
            self.collectionView.reloadData()
        })
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:
            "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
       @IBAction func createNewMeme(_ sender: Any) {
         performSegue(withIdentifier: "newMemeSegue",
         sender: self)
     }
    
    
}
