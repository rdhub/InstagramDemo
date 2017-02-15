//
//  LoginViewController.swift
//  Instagram
//
//  Created by Richard Du on 2/14/17.
//  Copyright © 2017 Richard Du. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignUp(_ sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        let alertController = UIAlertController(title: "", message: "Sign up successful.\nYou may now log in.", preferredStyle: .alert)
        
        let alertController2 = UIAlertController(title: "", message: "Username is taken.", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        alertController2.addAction(OKAction)
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("new user signed up")
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                
                self.present(alertController2, animated: true) {
                }
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "", message: "Username or password incorrect.", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user:PFUser?, error:Error?) in
            if user != nil {
                print("logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.present(alertController, animated: true) {
                    
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
