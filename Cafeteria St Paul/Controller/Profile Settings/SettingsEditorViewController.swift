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
    
    
}
