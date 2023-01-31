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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OrderDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.order = orders[indexPath.row]
        }
    }
    
    func loadOrders() {
        db.collection("orders2")
            .whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .order(by: "Interval", descending: false).getDocuments { querySnapshot, error in
                if error != nil {
                    ProgressHUD.showError("Error: \(error)")
                    print("There was an error retrieving the order from Firestore: \(error). Simple error description: \(error!.localizedDescription)")
                } else {
                    if let firestoreDocuments = querySnapshot?.documents {
                        if firestoreDocuments == [] {
                            ProgressHUD.showError("You haven't made any orders yet")
                        } else {
                            print("OK1")
                            print(firestoreDocuments)
                            for doc in firestoreDocuments {
                                print("OK2")
                                let orderNUMBER = doc.documentID
                                let data = doc.data()
                                if let dish = data["Platillo"] as? String,
                                    let date = data["Date"] as? String,
                                    let interval = data["Interval"] as? Int,
                                    let orderNum = orderNUMBER as? String,
                                    let userName = data["Nombre"] as? String,
                                    let hour = data["Hora"] as? String,
                                    let image = data["imageURL"] as? String {
                                    print("OK3")
                                    if interval > Int(Date().timeIntervalSince1970 - 60*60*14) {
                                        let order = Order(date: date, hour: hour, orderNum: orderNum, userName: userName, dishName: dish, imageURL: image)
                                        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Haptics.selectionVibration()
        self.performSegue(withIdentifier: "showOrder", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
