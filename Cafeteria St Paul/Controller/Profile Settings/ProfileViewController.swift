//
//  ProfileViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/13/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    //MARK: - Vars and lets
    @IBOutlet weak var tableView: UITableView!
    
    var pageTitle: String? {
        didSet{
            title = pageTitle
        }
    }
    let db = Firestore.firestore()
    
    
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
            destinationVC.propertyBeingEdited = SettingsList.settingsList[indexPath.row].label
        }
    }
}


//MARK: - TableView Methods


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsList.settingsList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.setUpCell(setting: SettingsList.settingsList[indexPath.row])
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == SettingsList.settingsList.count - 1 {
            do {
                try Auth.auth().signOut()
                self.parent?.navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        } else {
            performSegue(withIdentifier: "showSettingsEditor", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}


