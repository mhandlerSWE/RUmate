//
//  RegisterViewController.swift
//  RUmateApp
//
//  Created by Max Handler on 7/7/21.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let RUred = CGColor(red: 204/255, green: 0/255, blue: 51/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.firstNameTextField.layer.borderColor = RUred
        self.firstNameTextField.layer.borderWidth = 1
        
        self.lastNameTextField.layer.borderColor = RUred
        self.emailTextField.layer.borderColor = RUred
        self.passwordTextField.layer.borderColor = RUred
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
