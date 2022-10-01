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
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var userNum = 0
    let db = Firestore.firestore()
    
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
        
        ProgressHUD.show("Activating account...")
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //self.errorLabel.text = e.localizedDescription
                    Haptics.errorVibration()
                    ProgressHUD.showError(e.localizedDescription)
                } else {
                    self.alert(passwordEntered: password)
                }
            }
        }
        
    }
    func alert(passwordEntered: String) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Enter your new password🔒", message: "", preferredStyle: .alert)
        alert.addTextField { popUpTextField in
            popUpTextField.isSecureTextEntry = true
            popUpTextField.font = UIFont.systemFont(ofSize: 18.0)
            popUpTextField.textContentType = .password
            popUpTextField.placeholder = "Password"
            alertTextField = popUpTextField
        }
        
        let action = UIAlertAction(title: "Confirm", style: .default) { alertAction in
            
            if alertTextField.text != nil || alertTextField.text != "".trimmingCharacters(in: .whitespacesAndNewlines) {
                self.changePassword(newValue: alertTextField.text!, password: passwordEntered)
            }
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func changePassword(newValue: String, password: String) {
        var credential: AuthCredential
        let currentUserEmail = Auth.auth().currentUser?.email
        credential = EmailAuthProvider.credential(withEmail: currentUserEmail!, password: password) //Se declara despues para primero darle un valor a "current user email" y que no sea tan largo
        
        if let user = Auth.auth().currentUser {
            // re authenticate the user
            user.reauthenticate(with: credential) {reauthenticationResult, error in
                if let e = error {
                    print("There was an error reauthenticating the user: \(e) / \(e.localizedDescription)")
                    ProgressHUD.showError(e.localizedDescription)
                    Haptics.errorVibration()
                } else {
                    print("HERES THE REAUTHENTICATION RESULT \(reauthenticationResult!)")
                        user.updatePassword(to: newValue) { (error) in
                            if error != nil {
                                ProgressHUD.showError(error?.localizedDescription)
                                Haptics.errorVibration()
                                self.signOut()
                            } else {
                                self.activateUsr(uid: Auth.auth().currentUser!.uid)
                            }
                        }
                    }
                }
            }
    }
    
    func activateUsr(uid: String) {
        db.collection("users").document(uid).setData([
            "activated" : true
        ], merge: true) { error in
            if let e = error {
                print("THERE WAS AN ERROR CHANGING THE VALUE: \(e)")
                ProgressHUD.showError(e.localizedDescription)
                self.signOut()
            } else {
                print("document saved successfully")
                ProgressHUD.showSuccess("Account activated succesfully")
                Haptics.successVibration()
                self.signOut()
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    /*
    func registerUser() {
        var user = Users.AllUsers[userNum]
        let db = Firestore.firestore()
        DispatchQueue.main.async {
                    let email = user.email.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = "@**\(user.carne)**@"
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let e = error {
                            Haptics.errorVibration()
                            ProgressHUD.showError(e.localizedDescription)
                            
                        } else {
                            db.collection("users").document(authResult!.user.uid).setData(
                                [
                                    "name" : user.name,
                                    "studentID" : user.carne,
                                    "grade" : user.grado.trimmingCharacters(in: .whitespacesAndNewlines),
                                    "activated" : false,
                                    "uid" : authResult!.user.uid
                                ]
                            )
                            { error in
                                if error != nil {
                                    Haptics.errorVibration()
                                    ProgressHUD.showError(error?.localizedDescription)
                                } else {
                                    sleep(1)
                                    self.userNum += 1
                                    print("User \(self.userNum) registered successfully")
                                    ProgressHUD.showSuccess()
                                    //                                self.performSegue(withIdentifier: "successfulRegister", sender: self)
                                }
                            }
                        }
                    }
                }
            }
     */
}
