//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Elena Rybina on 7/31/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import Foundation
import UIKit

class SentMemeTableViewController: UITableViewController, UITabBarDelegate {
    var memes: [Meme] = GlobalConfig.singleton.memeList
    
    @IBOutlet weak var newMeme: UIBarButtonItem!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalConfig.singleton.subscribeOnChange({ memeList in
            self.memes = memeList
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCollectionViewCell")!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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
