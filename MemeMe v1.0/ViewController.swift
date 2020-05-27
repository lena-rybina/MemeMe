//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by Ielena Rybina on 5/22/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate = self
        present (imagePicker, animated: true, completion: nil)

    }
 
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imagePicker.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}

