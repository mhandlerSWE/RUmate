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
            
            let fullName = "\(firstName) \(lastName)"
            
            registerRequest(name: fullName, email: email, password: password) { (result, error) in
                if let result = result {
                    print("New User Created: \(result["user"] ?? "nil")")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
    
                } else if let error = error {
                    print("error: \(error.localizedDescription)")
                    
                }
            }
            
        }
    
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        //return back to login screen
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerRequest(name: String, email: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {

        let parameters = [
            
            "name": name,
            "email": email,
            "password": password,
            "preferences": [
                
                "bio": "Sample Bio",
                "classyear": "2024",
                "major": "Sample Major"
            ]
            
        ] as [String : Any]

        let url = URL(string: "http://localhost:3000/api/user/register")!
        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

    
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }

            do {
            
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                
                completion(json, nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
                
            }
        })

        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        
    }
    
}
