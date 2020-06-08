//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by Ielena Rybina on 5/22/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit

class ViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate,
    UITabBarDelegate {

    @IBOutlet weak var containerCenterYLayout: NSLayoutConstraint!
    @IBOutlet weak var imagePickerImageView: UIImageView!
    @IBOutlet weak var cameraTabbarItem: UITabBarItem!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .strokeColor: UIColor.black,
        .strokeWidth: -2,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .backgroundColor: UIColor.clear,
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        subscribeToKeyboardNotifications()
        
        textField1.delegate = self
        textField1.borderStyle = .none
        textField1.defaultTextAttributes = memeTextAttributes
        textField1.textAlignment = .center
        
        textField2.delegate = self
        textField2.borderStyle = .none
        textField2.defaultTextAttributes = memeTextAttributes
        textField2.textAlignment = .center
        
        textField1.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        textField2.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraTabbarItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true;
      }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func tabBar(_ tabBar: UITabBar,
                didSelect item: UITabBarItem) {
        guard let title = item.title else { return }
        switch title {
        case "Camera":
            let imagePicker = UIImagePickerController ()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present (imagePicker, animated: true, completion: nil)
        case "Gallery":
            let imagePicker = UIImagePickerController ()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present (imagePicker, animated: true, completion: nil)
        default: return
        }
    }
   
    // KeyBoard

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if textField2.isFirstResponder {
            containerCenterYLayout.constant = -getKeyboardHeight(notification)
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
   
    @objc func keyboardWillHide(_ notification:Notification) {
        containerCenterYLayout.constant = 0
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
