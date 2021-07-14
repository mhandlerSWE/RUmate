//
//  RegisterViewController.swift
//  RUmateApp
//
//  Created by Max Handler on 7/7/21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let RUred = CGColor(red: 204/255, green: 0/255, blue: 51/255, alpha: 1.0)
    
    func validateFields() -> String? {
            //Check that all fields are filled in
        if(firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields."
        }
            
        //Check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        if(isPasswordValid(cleanedPassword)) == false {
            //password isn't secure
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
            
        return nil
    }
        
    func isPasswordValid(_ password : String) -> Bool {
        //check the password to see if it fits within the regualar expression
        //RegEx: at least 8 characters, contains a special character, contains a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    @IBAction func didTapRegisterAccountButton(_ sender: Any) {
        //register user with firebase auth
        
        let error = validateFields()
        
        if(error != nil) { print(error!) } else {
            
            if(passwordTextField.text != confirmPasswordTextField.text) {
                print("passwords do not match") //confirm password does not match
                return
            }
            
            //create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //there was an error in creating the user
                    print(err?.localizedDescription ?? "no description for error")
                    
                } else {
                    
                    //user was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    db.collection("users").document("\(result!.user.uid)").setData([
                                                                                                
                        "firstName" : firstName,
                        "lastName" : lastName,
                        "email" : email,
                        "uid" : result!.user.uid
                                
                    ]) { (error) in
                        
                        if error != nil {
                            //show error message
                            print(error?.localizedDescription ?? "no description for error")
                                
                        } else {
                            print("user created successfully and stored in firestore")
                            
                        }
                        
                    }
                    
                }
            }
            
            self.transitionToHome()
            
        }
        
        
    }
    
    func transitionToHome() {
        //code to go to home screen here.
    
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        //return back to login screen
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        
    }
    
}
