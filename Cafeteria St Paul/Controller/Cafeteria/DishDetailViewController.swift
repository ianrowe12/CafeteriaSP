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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "es_CR")
        dateFormatter.timeZone = .current
        formattedDate = dateFormatter.string(from: dateToUse) //Estas dos variables tienen que ser cambiadas en caso de reutilizar la función
        intervalDate = dateToUse.timeIntervalSince1970
    }
    
    //MARK: - Compra y exportación de datos a Firestore
    @IBAction func purchaseTapped(_ sender: Any) {
        //Si el completion handler de la compra da positivo entonces:
        ProgressHUD.show("Placing Order...")
        sendOrder()
    }
    
    func sendOrder() {
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



