//
//  LoginViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 8/13/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🟡 St Paul Cafeteria 🟢"
        signInButton.layer.cornerRadius = 10
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    Haptics.errorVibration()
                } else {
                    self.performSegue(withIdentifier: "signInSuccessful", sender: self)
                    Haptics.successVibration()
                }
            }
        }
    }
    
}

