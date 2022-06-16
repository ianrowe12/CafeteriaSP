//
//  ProfileViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/13/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let settingsList = ["Appearance", "Change email", "Change Password", "Sign Out"]
    
    var pageTitle: String? {
        didSet{
            
            title = pageTitle
        }
    }
    
    let db = Firestore.firestore()
    
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = .zero
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        retrieveName()
    }
    
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
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        let currentItem = settingsList[indexPath.row]
        cell.textLabel?.text = currentItem
        return cell
    }
    
    
}
