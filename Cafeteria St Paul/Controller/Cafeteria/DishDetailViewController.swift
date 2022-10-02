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
    @IBOutlet weak var textField: UITextField!
    
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
        formatDate(dateToUse: HomeViewController.selectedDate!)
        textField.delegate = self
        
    
        Func.bringArray(whichArray: "popularsList") { [self] populars in
            for dish in populars {
                if selectedDetail!.name == dish {
                    textField.placeholder = "No available sides for this dish‼️"
                }
            }
        }
    
    
}
//MARK: - Poblar la pantalla con los datos
func setup(with Dish: Dish){
    detailImage.kf.setImage(with: URL(string: Dish.imageURL))
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
    if textField.text == "".trimmingCharacters(in: .whitespacesAndNewlines) {
        self.alert(wroteText: false)
    } else {
        self.alert(wroteText: true)
    }
    
}

func alert(wroteText: Bool) {
    var alert = UIAlertController()
    
    if wroteText == false {
        alert = UIAlertController(title: "Are you sure you want to eat this on \(internalFormattedDate ?? "the selected date"), and leave no notes for your order?", message: "", preferredStyle: .alert)
    } else {
        alert = UIAlertController(title: "Are you sure you want to eat this on \(internalFormattedDate ?? "the selected date")?", message: "", preferredStyle: .alert)
    }
    
    let proceedAction = UIAlertAction(title: "Yes", style: .default) { alertAction in
        self.warningAlert()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { alertAction in
    }
    alert.addAction(proceedAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
}


func warningAlert() {
    
    let alert = UIAlertController(title: "Warning", message: "Since the cafeteria might buy the ingredients beforehand to fulfill your order, there is NO way to cancel it once you've placed it.", preferredStyle: .alert)
    
    let placeOrderAction = UIAlertAction(title: "Place Order", style: .default) { alertAction in
        self.sendOrder()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { alertAction in
    }
    alert.addAction(placeOrderAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
}


func sendOrder()  {
    ProgressHUD.show("Placing Order...🧑‍🍳")
    //var orderId: Int = 0
    self.db.collection("orders2").order(by: "orderId", descending: true).limit(to: 1).getDocuments { querySnapshot, error in
        if error != nil {
            print("There was an error retrieving the order from Firestore: \(error). Simple error description: \(error!.localizedDescription)")
        } else {
            if let firestoreDocuments = querySnapshot?.documents {
                if firestoreDocuments == [] {
                    print("no hay nada")
                } else {
                    var orderNum = 0
                    for doc in firestoreDocuments {
                        //let data = doc.data()
                        let data = doc.documentID
                        //orderNum = data["orderId"] as! Int
                        orderNum = Int(data)!
                        print(orderNum)
                    }
                    self.getFromUsersCollection() { [self] username, id, grade in
                        self.db.collection("orders2").document(String(orderNum + 1)).setData([
                            "Carné" : id,
                            "Nombre" : username,
                            "Sección" : grade,
                            "Date" : self.formattedDate!,
                            "Platillo": self.selectedDetail?.name ?? "error",
                            "Interval": self.intervalDate!,
                            "uid" : Auth.auth().currentUser!.uid,
                            "orderId" : orderNum + 1,
                            "Retirado" : false,
                            "imageURL": self.selectedDetail?.imageURL,
                            "details" : textField.text ?? "",
                        ])
                        { error in
                            if let e = error {
                                ProgressHUD.showError("Error while placing your order")
                                print(e)
                            } else {
                                ProgressHUD.showSuccess("Order placed Succesfully")
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}



func getFromUsersCollection(completionHandler:@escaping(String, Int, String) -> ()){
    db.collection("users").document(Auth.auth().currentUser!.uid).getDocument { documentSnapshot, error in
        if error != nil {
            
            print("THERE WAS AN ERROR accessing firestore documents: \(error!.localizedDescription)")
        } else {
            if let data = documentSnapshot?.data(){
                
                let username = data["name"] as? String
                let id = data["studentID"] as? Int
                let grade = data["grade"] as? String
                
                completionHandler (username!, id!, grade!)
            }
        }
    }
}

}

extension DishDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let curruntCharachterCount = textField.text?.count ?? 0
        if range.length + range.location > curruntCharachterCount{
            return false
        }
        let newLength = curruntCharachterCount + string.count - range.length
        return newLength <= 45 // set max limit of numbers
    }
}


