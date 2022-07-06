//
//  PasswordResetViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 7/5/22.
//

import UIKit
import Firebase
import ProgressHUD

class PasswordResetViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
    }

    @IBAction func sendResetEmail(_ sender: Any) {
        if emailTextField.text == "".trimmingCharacters(in: .whitespacesAndNewlines) {
            ProgressHUD.showError("Enter your email")
        } else {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                } else {
                    ProgressHUD.showSuccess("The email has been sent. Check the junk inbox")
                }
            }
        }
        
    }
}
