//
//  InitialViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/25/22.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        for item in dishBrain.snackSalado {
//            db.collection("Dishes").document("All").collection("fastSnacks").document(item.name).setData([
//                "Description" : item.description,
//                "imageURL" : item.imageURL,
//                "name" : item.name,
//                "price" : item.price,
//            ])
//        }
        
        db.collection("Dishes").document("All").collection("Lunch").document("Casado").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("Lunch").document("Cordon Bleu").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("Lunch").document("Fries & Nuggets").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("Lunch").document("Lasagna Bolognese").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("Lunch").document("Pastel de Papa").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("Lunch").document("Pizza").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("specialDishes").document("Cordon Bleu").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("specialDishes").document("Lasagna Bolognese").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])
        db.collection("Dishes").document("All").collection("specialDishes").document("Pastel de Papa").updateData([
            "dates" : FieldValue.arrayUnion(["05/08/2022"])
                    ])

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
