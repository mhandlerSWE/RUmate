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
        //login user with firebase auth
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        //send user to registration page
        self.performSegue(withIdentifier: "toRegisterAccountView", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.logInButton.layer.cornerRadius = 10
        self.logInButton.clipsToBounds = true
        
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
