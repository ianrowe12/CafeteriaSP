//
//  ProfileViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/13/22.
//

import UIKit
import Firebase
import ProgressHUD

class ProfileViewController: UIViewController {
    
    //MARK: - Vars and lets
    @IBOutlet weak var tableView: UITableView!
    
    var pageTitle: String? {
        didSet{
            title = pageTitle
        }
    }
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var controller: UIViewController!
    
    
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = .zero
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        //retrieveName()
        registerFirstCell()
        registerSecondCell()
        //mySceneDelegate = self.view.window!.windowScene!.delegate
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveName()
    }
    
    //MARK: - Functions
    
    func retrieveName() {
        db.collection("users").document(Auth.auth().currentUser!.uid).getDocument { documentSnapshot, error in
            if error != nil {
                print("THERE WAS AN ERROR \(error!.localizedDescription)")
            } else {
                if let data = documentSnapshot?.data(){
                    if let username = data["name"] as? String {
                        self.pageTitle = username
                    }
                }
            }
        }
    }
    
    func registerFirstCell() {
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
    }
    func registerSecondCell() {
        tableView.register(UINib(nibName: "SwitchSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchSettingTableViewCell")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SettingsEditorViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.propertyBeingEdited = SettingsList.settingsList[indexPath.row - 1].label
        }
    }
}


//MARK: - TableView Methods


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsList.settingsList.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        
        if indexPath.row == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchSettingTableViewCell", for: indexPath) as! SwitchSettingTableViewCell
            cell.setUpCell(setting: SlideSetting(label: "Dark Mode", image: UIImage(imageLiteralResourceName: "appearance"), darkMode: UserDefaults.standard.bool(forKey: "darkMode")))
            return cell
        } else {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.setUpCell(setting: SettingsList.settingsList[indexPath.row - 1])
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Haptics.selectionVibration()
        if indexPath.row == SettingsList.settingsList.count {
            do {
                try Auth.auth().signOut()
                defaults.setValue(false, forKey: "wantsSessionPersistence")
                controller = storyBoard.instantiateViewController(withIdentifier: "firstNav") as! UINavigationController
                SceneDelegate.window?.rootViewController = controller
                self.parent?.navigationController?.popToRootViewController(animated: true)
                //mySceneDelegate.window?.rootViewController = controller
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                ProgressHUD.showError(signOutError.localizedDescription)
            }
        } else {
            performSegue(withIdentifier: "showSettingsEditor", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}


