//
//  registerViewController.swift
//  LIFETAG
//
//  Created by Pawandeep Singh on 11/12/17.
//  Copyright © 2017 Pawandeep Singh. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase

class registerViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var rePasswordTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var DOBTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var zipCodeTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emergencyTxt: UITextField!
     var ref: DatabaseReference!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // Check if email already exists in the database
    func fetchProviders(forEmail email: String, completion: ProviderQueryCallback? = nil){
        displayAlert(title: "Email in use", message: "Account with the following \(self.emailTxt.text!) already exists")
    }
    
    @IBAction func submitButton(_ sender: Any) {
      
        
        if emailTxt.text == "" || passwordTxt.text == "" || rePasswordTxt.text == "" || firstNameTxt.text == "" || lastNameTxt.text == "" || DOBTxt.text == "" || addressTxt.text == "" || cityTxt.text == "" || stateTxt.text == "" || zipCodeTxt.text == "" || phoneTxt.text == "" || emergencyTxt.text == "" {
           self.displayAlert(title: "Missing Field(s)", message: "One or more field's are missing")
        }
            
        else {
            // Reference to FireBase database
            ref = Database.database().reference().child("Users");
            
            // Authentication -> passes email and password to be stored
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) {
                (user, error) in
                //If any error during the submission of the user info come here
                if error != nil{
                    Auth.auth().fetchProviders(forEmail: self.emailTxt.text!) { (providers, error) in
                    }
                    // function call to check if  email exists
                    self.fetchProviders(forEmail: self.emailTxt.text!)
                }
                    // If "Signup" Page was successful, code below is excuted
                else {
                     let userID = Auth.auth().currentUser?.uid
                    let key = userID
                    print("THis is the key \(key)")
                    let user = ["id":key,
                                "email": self.emailTxt.text! as String,
                                "FirstName": self.firstNameTxt.text! as String,
                                "LastName": self.lastNameTxt.text! as String,
                                "DOB": self.DOBTxt.text! as String,
                                "Address": self.addressTxt.text! as String,
                                "City": self.cityTxt.text! as String,
                                "State": self.stateTxt.text! as String,
                                "Zip": self.zipCodeTxt.text! as String,
                                "Phone": self.phoneTxt.text! as String,
                                "emergencyContact": self.emergencyTxt.text! as String,
                                "QRcode": "URL:"
                        //QR contains persons info
                        
                    ]
                    //Line below submits the info to the database
                    self.ref.child(key!).setValue(user)
                    self.displayAlert(title: "Registeration Completed", message: "You may go back and login!")

                    
                    
                }
        }
    }
        
  

 
}
}
