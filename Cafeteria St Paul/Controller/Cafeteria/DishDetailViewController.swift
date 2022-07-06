//
//  DishDetailViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit
import Firebase
import ProgressHUD

class DishDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var dishDetailTitle: UILabel!
    @IBOutlet weak var dishDetailPrice: UILabel!
    @IBOutlet weak var dishDetailDescription: UILabel!
    
    //MARK: - Variables and constants
    var selectedDetail: Dish?
    var formattedDate: String?
    var intervalDate: Double?
    
    var internalFormattedDate: String? //This one will be used for the alert to let users know the time for which they're buying
    
    let db = Firestore.firestore()
    var Carné: String?
    var Nombre: String?
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setup(with: selectedDetail!)
        formatDate(dateToUse: HomeViewController.selectedDate)
    }
    //MARK: - Poblar la pantalla con los datos
    func setup(with Dish: Dish){
        detailImage.image = Dish.image
        dishDetailTitle.text = Dish.name
        dishDetailPrice.text = Dish.price
        dishDetailDescription.text = Dish.description
    }
    
    //MARK: - Date Handler
    func formatDate(dateToUse: Date){
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .full
        dateFormatter1.locale = Locale(identifier: "es_CR")
        dateFormatter1.timeZone = .current
        formattedDate = dateFormatter1.string(from: dateToUse) //Estas dos variables tienen que ser cambiadas en caso de reutilizar la función
        intervalDate = dateToUse.timeIntervalSince1970
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .full
        dateFormatter2.locale = Locale(identifier: "en_US")
        dateFormatter2.timeZone = .current
        internalFormattedDate = dateFormatter2.string(from: dateToUse)
    }
    
    //MARK: - Compra y exportación de datos a Firestore
    @IBAction func purchaseTapped(_ sender: Any) {
        alert()
    }
    
    func alert() {
        
        let alert = UIAlertController(title: "Are you sure you want to eat this on \(internalFormattedDate ?? "the selected date")?", message: "", preferredStyle: .alert)
        let proceedAction = UIAlertAction(title: "Yes, Proceed to Checkout", style: .default) { alertAction in
            self.sendOrder() //Si el completion handler de la compra da positivo entonces:
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { alertAction in
        }
        alert.addAction(proceedAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func sendOrder() {
        ProgressHUD.show("Placing Order...🧑‍🍳")
        self.getFromUsersCollection() { [self] username, id in
            self.db.collection("orders").document((Auth.auth().currentUser!.uid)).collection("2022").addDocument(data: [
                "Carné" : id,
                "Nombre" : username,
                "Date" : self.formattedDate!,
                "Platillo": self.selectedDetail?.name ?? "error",
                "Interval": self.intervalDate!
            ]) { error in
                if let e = error {
                    ProgressHUD.showError("Error while placing your order")
                    print(e)
                } else {
                    ProgressHUD.showSuccess("Order placed Succesfully")
                }
            }
        }
    }
    
    
    func getFromUsersCollection(completionHandler:@escaping(String, String) -> ()){
        db.collection("users").document(Auth.auth().currentUser!.uid).getDocument { documentSnapshot, error in
            if error != nil {
                
                print("THERE WAS AN ERROR accessing firestore documents: \(error!.localizedDescription)")
            } else {
                if let data = documentSnapshot?.data(){
                    
                    let username = data["name"] as? String
                    let id = data["studentID"] as? String
                    
                    completionHandler (username!, id!)
                }
            }
        }
    }
}



