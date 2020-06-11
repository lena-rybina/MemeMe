//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by Ielena Rybina on 5/22/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit

class MemeEditorViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate,
    UITabBarDelegate {

    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var bottomLabelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var popoverSource: UIBarButtonItem!
    @IBOutlet weak var clearAll: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imagePickerImageView: UIImageView!
    @IBOutlet weak var cameraTabbarItem: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var snapshotImage: UIImage = UIImage()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .strokeColor: UIColor.black,
        .strokeWidth: -2,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .backgroundColor: UIColor.clear
    ]
    
    func memeTextStyle(_ textField: UITextField,
                       withPlaceholderTitle placeholder: String) {
        textField.borderStyle = .none
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: memeTextAttributes)
         textField.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        subscribeToKeyboardNotifications()
        
        memeTextStyle(topTextField,
                      withPlaceholderTitle: "TOP")
        memeTextStyle(bottomTextField,
                      withPlaceholderTitle: "BOTTOM")
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
    
    func imagePickerConfigurator(for type: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present (imagePicker, animated: true, completion: nil)
    }
    
    func tabBar(_ tabBar: UITabBar,
                didSelect item: UITabBarItem) {
        guard let title = item.title else { return }
        switch title {
        case "Camera":
            imagePickerConfigurator (for: .camera)
        case "Gallery":
            imagePickerConfigurator (for: .photoLibrary)
        default: return
        }
    }
    
    @IBAction func onShareTap(_ sender: Any) {
        snapshotImage = containerView.generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [snapshotImage],
                                                    applicationActivities: nil)
        activityView.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        activityView.completionWithItemsHandler = { _, isCompleted, items, _ in
            guard isCompleted else { return }
            self.save()
        }
        
        present(activityView, animated: true, completion: nil)
    }
    
    func save() {
        guard let topText = topTextField.text,
            let bottomText = bottomTextField.text,
            let originalImage = imagePickerImageView.image else { return }
        
        let meme = Meme(topText: topText,
                        bottomText: bottomText,
                        originalImage: imagePickerImageView.image!,
                        memedImage: snapshotImage)
    }
   
    @IBAction func clearAll(_ sender: Any) {
        topTextField.text = ""
        bottomTextField.text = ""
        imagePickerImageView.image = nil
    }
    
    
    // KeyBoard and Editing
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let distanceFromKeyboardTocontainer = -getKeyboardHeight(notification) + tabBar.frame.height
        bottomLabelBottomConstraint.constant = -distanceFromKeyboardTocontainer
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
   
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomLabelBottomConstraint.constant = 10
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




