//
//  SettingsEditorViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 7/2/22.
//

import UIKit
import Firebase
import ProgressHUD

class SettingsEditorViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    var propertyBeingEdited: String? //receives a value from previous view controller
    
    var db = Firestore.firestore()
    
    var settingsDict: [String : String] = [
        K.settingsLabels.email : "Email",
        K.settingsLabels.id : "Carné",
        K.settingsLabels.password : "Password",
        K.settingsLabels.username : "Username"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = "Enter your new \(settingsDict[propertyBeingEdited!] ?? "value")"
        
        if propertyBeingEdited == K.settingsLabels.password {
            textField.textContentType = .password
            textField.isSecureTextEntry = true
        } else {
            textField.textContentType = .username
        }
        
        title = settingsDict[propertyBeingEdited!] ?? "Change Property"
    }
    
    
    @IBAction func changeTapped(_ sender: Any) {
        ProgressHUD.show("Changing \(settingsDict[propertyBeingEdited!] ?? "property...")...")
        
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            ProgressHUD.showError("Enter a new valid \(settingsDict[propertyBeingEdited!] ?? "value")")
        } else {
            switch propertyBeingEdited {
            case K.settingsLabels.username:
                return editUsrEntry(property: "name", newValue: textField.text!)
            case K.settingsLabels.id:
                return editUsrEntry(property: "studentID", newValue: textField.text!)
            case K.settingsLabels.email:
                return alert(valueToChange: "Email", newValue: textField.text!)
            case K.settingsLabels.password:
                return alert(valueToChange: "Password", newValue: textField.text!)
            default:
                return ProgressHUD.show("Nothing to cover this yet")
            }
        }
        
    }
    
    func editUsrEntry(property: String, newValue: String) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData([
            property : newValue
        ], merge: true) { error in
            if let e = error {
                print("THERE WAS AN ERROR CHANGING THE VALUE: \(e)")
                ProgressHUD.showError(e.localizedDescription)
            } else {
                print("document saved successfully")
                ProgressHUD.showSuccess("\(self.settingsDict[self.propertyBeingEdited!] ?? "Value") changed successfully")
            }
        }
    }
    
    func alert(valueToChange: String, newValue: String) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Alright, but first, enter your current password🔒", message: "", preferredStyle: .alert)
        alert.addTextField { popUpTextField in
            popUpTextField.isSecureTextEntry = true
            popUpTextField.font = UIFont.systemFont(ofSize: 18.0)
            popUpTextField.textContentType = .password
            popUpTextField.placeholder = "Password"
            alertTextField = popUpTextField
        }
        
        let action = UIAlertAction(title: "Confirm", style: .default) { alertAction in
            
            if alertTextField.text != nil || alertTextField.text != "".trimmingCharacters(in: .whitespacesAndNewlines) {
                self.changeEmail(valueToChange: valueToChange, newValue: newValue, password: alertTextField.text!)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func changeEmail(valueToChange: String, newValue: String, password: String) {
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
                    print("HERES THE REAUTHENTICATION RESULT \(reauthenticationResult)")
                    if valueToChange == "Email" {
                        user.updateEmail(to: newValue) { (error) in
                            if error != nil {
                                print("There was an error changing the email. \(error)")
                                ProgressHUD.showError(error?.localizedDescription)
                                Haptics.errorVibration()
                            } else {
                                ProgressHUD.showSuccess("Email changed successfully")
                                Haptics.successVibration()
                            }
                        }
                    } else {
                        user.updatePassword(to: newValue) { (error) in
                            if error != nil {
                                ProgressHUD.showError(error?.localizedDescription)
                                Haptics.errorVibration()
                            } else {
                                ProgressHUD.showSuccess("Password changed successfully")
                                Haptics.successVibration()
                            }
                        }
                    }
                }
            }
        }
    }
    
    

}
