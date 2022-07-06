//
//  LoginViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 8/13/21.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var nextViewIsHome = false
    let defaults = UserDefaults.standard
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {        
        changeNextViewBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "🟡 St Paul Cafeteria 🟢"
        emailField.smartQuotesType = .yes
        emailField.smartInsertDeleteType = .yes
        emailField.textContentType = .username
    }
    
    func changeNextViewBar() {
        if nextViewIsHome {
            navigationController?.navigationBar.isHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInSuccessful" {
            nextViewIsHome = true
        } else {
            nextViewIsHome = false
        }
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "showPasswordReset", sender: self)
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        ProgressHUD.show("Signing in...")
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //self.errorLabel.text = e.localizedDescription
                    Haptics.errorVibration()
                    ProgressHUD.showError(e.localizedDescription)
                } else {
                    self.staySignedInAlert()
                }
            }
        }
    }
    
    func staySignedInAlert() {
        let mainAlert = UIAlertController(title: "Do you want to stay signed in?", message: "This will save you time every time you open the app. If you want more security though, you should tap 'No'", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { alertAction in
            self.defaults.setValue(true, forKey: "wantsSessionPersistence")
            self.successfulNSegue()
        }
        let noAction = UIAlertAction(title: "No", style: .destructive) { alertAction in
            self.defaults.setValue(false, forKey: "wantsSessionPersistence")
            self.successfulNSegue()
        }
        
        mainAlert.addAction(yesAction)
        mainAlert.addAction(noAction)
        
        present(mainAlert, animated: true)        
    }
    
    func successfulNSegue() {
        self.performSegue(withIdentifier: "signInSuccessful", sender: self)
        Haptics.successVibration()
        ProgressHUD.dismiss()
    }
    
}

