//
//  InitialViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/25/22.
//

import UIKit

class InitialViewController: UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) { // Just before the view appears
        super.viewWillAppear(animated) // when overriding, you must call super at some point
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) { // just before the view changes
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 10
        createAccountButton.layer.cornerRadius = 10
    }
    

}
