//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by Ielena Rybina on 5/22/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraToolBar: UIBarButtonItem!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField1.delegate = self
        self.textField2.delegate = self
        self.textField1.text = "TOP"
        self.textField2.text = "BOTTOM"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                cameraToolBar.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present (imagePicker, animated: true, completion: nil)

    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
           let imagePicker = UIImagePickerController ()
           imagePicker.delegate = self
           imagePicker.sourceType = .camera
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

