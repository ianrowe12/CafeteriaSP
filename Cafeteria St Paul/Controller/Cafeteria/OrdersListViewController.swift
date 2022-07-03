//
//  OrdersListViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/27/22.
//

import UIKit
import Firebase
import ProgressHUD

class OrdersListViewController: UIViewController {
    
    var orders: [Order] = []
    let db = Firestore.firestore()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
        loadOrders()
        title = "Your Orders"
        ProgressHUD.show("Loading orders...")
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ProgressHUD.dismiss()
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
    }
    
    func loadOrders() {
        db.collection("orders")
            .document(String(Auth.auth().currentUser!.uid))
            .collection("2022")
            .order(by: "Interval", descending: false).getDocuments { querySnapshot, error in
                if error != nil {
                    print("There was an error retrieving the order from Firestore: \(error). Simple error description: \(error!.localizedDescription)")
                } else {
                    if let firestoreDocuments = querySnapshot?.documents {
                        print("OK1")
                        print(firestoreDocuments)
                        for doc in firestoreDocuments {
                            print("OK2")
                            let data = doc.data()
                            if let dish = data["Platillo"] as? String, let date = data["Date"] as? String, let interval = data["Interval"] as? Double{
                                print("OK3")
                                if interval > Date().timeIntervalSince1970 - 60*60*14 { //Make sure only pending orders are showing. They wont be shown if they're older than yesterday (60*60*14).
                                    let order = Order(dish: DishDictionary.myDict[dish]!, date: date)
                                    self.orders.append(order)
                                    print("OK4")
                                }
                                ProgressHUD.dismiss()
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
    }
    
}

extension OrdersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        let currentOrder = orders[indexPath.row]
        cell.setupCell(with: currentOrder)
        return cell
    }
    
}
