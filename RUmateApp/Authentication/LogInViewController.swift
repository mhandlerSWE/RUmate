//
//  LogInViewController.swift
//  RUmateApp
//
//  Created by Max Handler on 7/11/21.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBAction func didTapLogInButton(_ sender: Any) {
      
        let error = validateFields()
        
        if(error != nil) { print(error!) } else {
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            loginRequest(email: email, password: password) { (result, error) in
                if let result = result {
                    print("User Was Logged In: \(result["_id"] ?? "nil")")
                    print("Token Returned: \(result["token"] ?? "nil")")
                
                } else if let error = error {
                    print("error: \(error.localizedDescription)")
                    
                }
            }
        }
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        //send user to registration page
        self.performSegue(withIdentifier: "toRegisterAccountView", sender: self)
    }
    
    func validateFields() -> String? {
        
        if( emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please fill in all fields."
        }
        
        return nil
        
    }
    
    func loginRequest(email: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {

        let parameters = [
            
            "email": email,
            "password": password
            
        ] as [String : Any]

        let url = URL(string: "http://localhost:3000/api/user/login")!
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
        
        self.logInButton.layer.cornerRadius = 10
        self.logInButton.clipsToBounds = true
        
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        
        
    }
        
}
