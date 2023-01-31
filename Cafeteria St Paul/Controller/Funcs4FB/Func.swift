import Foundation
import Firebase
import ProgressHUD

let db = Firestore.firestore()
struct Func {
    
    
    static func bringArray(whichArray: String, completionHandler:@escaping([String]) -> Void) {
        var nameArray: [String] = []
        let currentWeekDay = Calendar.current.component(.weekday, from: HomeViewController.selectedDate!)
        
        db.collection("Dishes").document("All").collection(whichArray).getDocuments { querySnapshot, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            } else {
                if let firestoreDocument = querySnapshot?.documents {
                    for doc in firestoreDocument {
                        let data = doc.data()
                        
                        if let name = data["name"] as? String {
                            nameArray.append(name)
                            completionHandler (nameArray)
                        }
                    }
                }
            }
        }
    }
    
    
    
    static func bringDishes(fromCollection: String, whereField: String, has: [String], view1: UICollectionView, view2: UICollectionView, completionHandler: @escaping([Dish]) -> Void){
        
        var dishList: [Dish] = []
        let currentWeekDay = Calendar.current.component(.weekday, from: HomeViewController.selectedDate!)
        db.collection("Dishes").document("All").collection(fromCollection).getDocuments { querySnapshot, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            } else {
                if let firestoreDocuments = querySnapshot?.documents {
                    if firestoreDocuments == [] || currentWeekDay == 1 || currentWeekDay == 7 {
                        ProgressHUD.showError("No dishes available on weekends")
                        dishList = [] //quita los platillos traídos para que no se muestren porque es día de finde
                        DispatchQueue.main.async {
                            view1.reloadData()
                            view2.reloadData()
                        }
                    } else {
                        for doc in firestoreDocuments {
                            let data = doc.data()
                            if data["name"] as? String != "Pizza" {
                                if let description = data["Description"] as? String,
                                   let imageurl = data["imageURL"] as? String,
                                   let name = data["name"] as? String,
                                   let price = data["price"] as? String,
                                   let type = data["type"] as? String {
                                    let dish = Dish(name: name, imageURL: imageurl, price: price, description: description, type: type)
                                    
                                    dishList.append(dish)
                                    
                                    DispatchQueue.main.async {
                                        view1.reloadData()
                                        view2.reloadData()
                                    }
                                }
                            } else if data["name"] as? String == "Pizza" && currentWeekDay == 6 {
                                if let description = data["Description"] as? String,
                                   let imageurl = data["imageURL"] as? String,
                                   let name = data["name"] as? String,
                                   let price = data["price"] as? String,
                                   let type = data["type"] as? String {
                                    let dish = Dish(name: name, imageURL: imageurl, price: price, description: description, type: type)
                                    
                                    dishList.append(dish)
                                    
                                    DispatchQueue.main.async {
                                        view1.reloadData()
                                        view2.reloadData()
                                    }
                                }
                            }
                        }
                        ProgressHUD.dismiss()
                    }
                }
                
                completionHandler(dishList)
            }
        }
    }
    
    static func bringDishes4Date(date: String, fromCollection: String, view1: UICollectionView, view2: UICollectionView, completionHandler: @escaping([Dish]) -> Void){
        
        var dishList: [Dish] = []
        let currentWeekDay = Calendar.current.component(.weekday, from: HomeViewController.selectedDate!)
        db.collection("Dishes").document("All").collection(fromCollection).whereField("dates", arrayContainsAny: [date]).getDocuments { querySnapshot, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            } else {
                if currentWeekDay == 1 || currentWeekDay == 7 {
                    ProgressHUD.showError("No dishes available on weekends")
                } else {
                    if let firestoreDocuments = querySnapshot?.documents {
                        if firestoreDocuments == [] {
                            ProgressHUD.dismiss()
                        } else {
                            for doc in firestoreDocuments {
                                let data = doc.data()
                                if let description = data["Description"] as? String,
                                   let imageurl = data["imageURL"] as? String,
                                   let name = data["name"] as? String,
                                   let price = data["price"] as? String,
                                   let type = data["type"] as? String {
                                    let dish = Dish(name: name, imageURL: imageurl, price: price, description: description, type: type)
                                    dishList.append(dish)
                                    
                                    DispatchQueue.main.async {
                                        view1.reloadData()
                                        view2.reloadData()
                                    }
                                }
                            }
                            ProgressHUD.dismiss()
                        }
                    }
                }
                completionHandler(dishList)
            }
        }
    }
    
}
