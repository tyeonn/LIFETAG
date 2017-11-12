//
//  ViewController.swift
//  LIFETAG
//
//  Created by Pawandeep Singh on 11/11/17.
//  Copyright © 2017 Pawandeep Singh. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  //  var ref: DatabaseReference!
    
    @IBAction func loginButton(_ sender: Any) {
        //Validate: if username and password fields are filled
        if emailTextField.text == "" || passwordTextField.text == "" {
            // Displays an alert if thier not
            displayAlert(title: "Missing Field(s)", message: "Username and Password required")
        } // if statement
            //Otherwise it continues to go forward to Authenticate if check if username and passsword are correct and in the system
        else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (user, error) in
                if error != nil {
                    print("Incorrect");
                }//if
                    //if correct moves on to the next page after login
                else {
                  self.performSegue(withIdentifier: "login", sender: self)
                }//Else if Auth was successfull
            }//Auth
        }// else -- if fields weren't empty
    }//login button
    
    @IBAction func registerButton(_ sender: Any) {
         self.performSegue(withIdentifier: "register", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

