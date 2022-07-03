//
//  RegisterViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 8/13/21.
//

import UIKit
import Firebase
import ProgressHUD

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var studentIDField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🟡 St Paul Cafeteria 🟢"
        createAccountButton.layer.cornerRadius = 10
        navigationController?.navigationBar.prefersLargeTitles = false
        createAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passwordField.textContentType = .oneTimeCode // Quita esa vara amarilla de strong password entry
    }
    
    
    
    @IBAction func registerTapped(_ sender: Any) {
        
        ProgressHUD.show("Signing you up...")
        
        if nameField.text == "" || studentIDField.text == "" {
            errorLabel.text = "Please enter a name and student ID (carné)"
            ProgressHUD.showError()
        } else {
            if let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        self.errorLabel.text = "Error: \(e.localizedDescription)"
                        Haptics.errorVibration()
                        ProgressHUD.showError()
                        
                    } else {
                        let db = Firestore.firestore()
                        db.collection("users").document(authResult!.user.uid).setData(
                            [
                                "name" : self.nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "studentID" : self.studentIDField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                                "uid" : authResult!.user.uid
                            ]
                        )
                        { error in
                            if error != nil {
                                self.errorLabel.text = error?.localizedDescription
                                Haptics.errorVibration()
                                ProgressHUD.showError()
                            } else {
                                self.performSegue(withIdentifier: "successfulRegister", sender: self)
                                Haptics.successVibration()
                                ProgressHUD.dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
}
