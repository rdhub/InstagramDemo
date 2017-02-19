//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Richard Du on 2/16/17.
//  Copyright © 2017 Richard Du. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var captionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cancelButton.isEnabled = false
        submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPhotoTap(_ sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.camera
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        print(info)
        
        imageButton.setBackgroundImage(originalImage, for: .normal)
        imageButton.setTitle("", for: .normal)
        // Do something with the images (based on your use case)
        
        cancelButton.isEnabled = true
        submitButton.isEnabled = true
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onScreenTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        imageButton.setBackgroundImage(nil, for: .normal)
        imageButton.setTitle("Tap to select or take a photo", for: .normal)
        captionField.text = nil
        cancelButton.isEnabled = false
        submitButton.isEnabled = false
    }
    @IBAction func onSubmit(_ sender: AnyObject) {
        if let image = imageButton.backgroundImage(for: .normal) {
            Post.postUserImage(image: image, withCaption: captionField.text) { (success:Bool, error:Error?) in
                if success {
                    print("Successfully posted")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    //let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as  UIViewController
                
                    let tabBarController = storyboard.instantiateViewController(withIdentifier: "InstagramTabBarController") as! UITabBarController
                        tabBarController.selectedIndex = 1
                } else {
                    print("\(error!.localizedDescription)")
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
