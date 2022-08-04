
import UIKit
import Firebase
import ProgressHUD

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var popularDishesView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var specialDishesView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Vars and constants
    
    var FilteredPopular: [Dish] = []
    var FilteredSpecial: [Dish] = []
    var FilteredLunch: [Dish] = []
    var FilteredBreakfast: [Dish] = []
    var FilteredSnackSalado: [Dish] = []
    var FilteredDessert: [Dish] = []
    
    let calendar = Calendar.current
    
    let formatter = DateFormatter()
    
    static var selectedDate: Date?
    
    var stringedDate: String?
    
    let db = Firestore.firestore()
    
    
    //MARK: - View Will Dissappear
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cafeteria"
        
        HomeViewController.selectedDate = calendar.startOfDay(for: Date().addingTimeInterval(24*60*60)) //Sets default selected date for tomorrow at 00:00:00
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        popularDishesView.delegate = self
        popularDishesView.dataSource = self
        
        specialDishesView.delegate = self
        specialDishesView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        datePicker.minimumDate = Date().addingTimeInterval(24*60*60) //The minumum date to pick is tomorrow.
        
        registerCells()
        
        formatter.dateFormat = "dd/MM/yyyy"
        stringedDate = formatter.string(from: HomeViewController.selectedDate!)
        print(stringedDate!)
        
        DispatchQueue.main.async {
            self.filterByDate(date: self.stringedDate!)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    //MARK: - Date was changed
    
    @IBAction func dateChanged(_ sender: Any)  {
        HomeViewController.selectedDate = datePicker.date
        formatter.dateFormat = "dd/MM/yyyy"
        stringedDate = formatter.string(from: HomeViewController.selectedDate!)
        filterByDate(date: stringedDate!)
    }
    
    //MARK: - Variables depending on date
    func filterByDate(date: String) {
        
 
        populateDishes(forDate: date) { popular, breakfast, special, snacksalado in
            print("Waiting for completion Handler")
        }

    }
    //MARK: - Bringing Dishes from Firestore
    func populateDishes(forDate: String, completionHandler: @escaping([Dish], [Dish], [Dish], [Dish]) -> Void) {
        ProgressHUD.show("Loading Dishes🍴")
        

        
        bringDishes(fromCollection: "popularDishes", whereField: "name", has:  ["Fries & Nuggets", "Pizza"]) { [self] popularList in
            FilteredPopular = popularList
            
            
            Categories.categories[2].dishes = popularList // Fast Snacks
        }
        bringDishes(fromCollection: "Breakfast", whereField: "name", has:  ["Gallo Pinto", "Tortilla con Natilla"]) { [self] breakfastList in
            FilteredBreakfast = breakfastList
         
            Categories.categories[0].dishes = breakfastList //Breakfast
        }
//        bringDishes(fromCollection: "specialDishes", whereField: "name", has:  ["Cordon Bleu", "Lasagna Bolognese", "Pastel de Papa"]) { [self] specialdishesList in
//            FilteredSpecial = specialdishesList
//        }
        
        bringDishes4Date(date: forDate, fromCollection: "Lunch") { [self] lunches in
            bringDishes(fromCollection: "popularDishes", whereField: "name", has:  ["Fries & Nuggets", "Pizza"]) { [self] dishList in
                
                let concatenatedArray = lunches + dishList
                
                Categories.categories[1].dishes = concatenatedArray // Fast Snacks
            }
        }
        bringDishes4Date(date: forDate, fromCollection: "specialDishes") { [self] specialDishesList in
            FilteredSpecial = specialDishesList
        }
        
        
        completionHandler(FilteredPopular, FilteredBreakfast, FilteredSpecial, FilteredSnackSalado)
        
       
        ProgressHUD.dismiss()
        
        //        FilteredSpecial = []
        //        FilteredLunch = []
        //        FilteredBreakfast = []
        //        FilteredSnackSalado = []
        //        FilteredDessert = []
        
        
        //FilteredBreakfast = try await bringDish(fromCollection: "Breakfast", document: "Gallo Pinto")
        //FilteredBreakfast = await bringDish(fromCollection: "Breakfast", document: "Tortilla con Natilla")
        //        do {
        
        //FilteredPopular = await bringDishes(fromCollection: "popularDishes", whereField: "name", contains: "Fries & Nuggets")
        
        //        } catch {
        //            print("ERROR ASSIGNING PROPERTY")
        //            fatalError()
        //        }
        //FilteredPopular = await bringDishes(fromCollection: fromCollection, whereField: "name", contains: "Pizza") ?? []
        
        
        
        /*
         let collectionPath = db.collection("Dishes").document("All")
         
         collectionPath.collection(fromCollection).whereField("dates", arrayContainsAny: [forDate]).getDocuments { querySnapshot, error in
         self.bringDishes(error: error, querySnapshot: querySnapshot, fromCollection: fromCollection)
         }
         
         collectionPath.collection(fromCollection).whereField("name", in: ["Gallo Pinto"]).getDocuments { querySnapshot, error in
         self.bringDishes(error: error, querySnapshot: querySnapshot, fromCollection: fromCollection)
         }
         
         collectionPath.collection(fromCollection).whereField("name", in: ["Tortilla con Natilla"]).getDocuments { querySnapshot, error in
         self.bringDishes(error: error, querySnapshot: querySnapshot, fromCollection: fromCollection)
         }
         
         collectionPath.collection(fromCollection).whereField("name", in: ["Fries & Nuggets"]).getDocuments { querySnapshot, error in
         self.bringDishes(error: error, querySnapshot: querySnapshot, fromCollection: fromCollection)
         }
         
         collectionPath.collection(fromCollection).whereField("name", in: ["Pizza"]).getDocuments { querySnapshot, error in
         self.bringDishes(error: error, querySnapshot: querySnapshot, fromCollection: fromCollection)
         }*/
        
    }
    
    
    func bringDishes(fromCollection: String, whereField: String, has: [String], completionHandler: @escaping([Dish]) -> Void){
        
        var dishList: [Dish] = []
        db.collection("Dishes").document("All").collection(fromCollection).whereField(whereField, in: has).getDocuments { querySnapshot, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            } else {
                if let firestoreDocuments = querySnapshot?.documents {
                    if firestoreDocuments == [] {
                        ProgressHUD.dismiss()
                    } else {
                        for doc in firestoreDocuments {
                            let data = doc.data()
                            if let description = data["Description"] as? String, let imageurl = data["imageURL"] as? String, let name = data["name"] as? String, let price = data["price"] as? String {
                                let dish = Dish(name: name, imageURL: imageurl, price: price, description: description)
                                
                                //                                switch fromCollection {
                                //                                case "Lunch": self.FilteredLunch.append(dish)
                                //                                case "Dessert": self.FilteredDessert.append(dish)
                                //                                case "Breakfast": self.FilteredBreakfast.append(dish)
                                //                                case "specialDishes": self.FilteredSpecial.append(dish)
                                //                                case "popularDishes": self.FilteredPopular.append(dish)
                                //                                case "fastSnacks": self.FilteredSnackSalado.append(dish)
                                //                                default: ProgressHUD.showError("Error adding dishes")
                                //                                }
                                dishList.append(dish)
                                
                                DispatchQueue.main.async {
                                    self.popularDishesView.reloadData()
                                    self.specialDishesView.reloadData()
                                }
                            }
                        }
                    }
                }
                
                completionHandler(dishList)
            }
        }
    }
    
    func bringDishes4Date(date: String, fromCollection: String ,completionHandler: @escaping([Dish]) -> Void){
        
        var dishList: [Dish] = []
        db.collection("Dishes").document("All").collection(fromCollection).whereField("dates", arrayContainsAny: [date]).getDocuments { querySnapshot, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            } else {
                if let firestoreDocuments = querySnapshot?.documents {
                    if firestoreDocuments == [] {
                        ProgressHUD.dismiss()
                    } else {
                        for doc in firestoreDocuments {
                            let data = doc.data()
                            if let description = data["Description"] as? String, let imageurl = data["imageURL"] as? String, let name = data["name"] as? String, let price = data["price"] as? String {
                                let dish = Dish(name: name, imageURL: imageurl, price: price, description: description)
                                dishList.append(dish)
                                
                                DispatchQueue.main.async {
                                    self.popularDishesView.reloadData()
                                    self.specialDishesView.reloadData()
                                }
                            }
                        }
                    }
                }
                
                completionHandler(dishList)
            }
        }
    }
    
    
    
    
    //MARK: - Registering cells
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        popularDishesView.register(UINib(nibName: "DishCell", bundle: nil), forCellWithReuseIdentifier: "DishCell")
        specialDishesView.register(UINib(nibName: "SpecialDishCell", bundle: nil), forCellWithReuseIdentifier: "SpecialDishCell")
    }
    
    //MARK: - Preparing for segue
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let destinationVC = segue.destination as! DishDetailViewController
            if let indexPath = popularDishesView.indexPathsForSelectedItems?.first {
                destinationVC.selectedDetail = FilteredPopular[indexPath.row]
            } else if let indexPath = specialDishesView.indexPathsForSelectedItems?.first{
                destinationVC.selectedDetail = FilteredSpecial[indexPath.row]
            }
        } else if segue.identifier == "showList" {
            let destinationVC = segue.destination as! DishesListViewController
            if let indexPath = categoryCollectionView.indexPathsForSelectedItems?.first {
                destinationVC.currentCategory = Categories.categories[indexPath.row]
            }
        } else {
            _ = segue.destination as! OrdersListViewController
            
        }
        
    }
}




//MARK: - Collection view datasource and delegate methods

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return Categories.categories.count
        case popularDishesView:
            return FilteredPopular.count
        case specialDishesView:
            return FilteredSpecial.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.setUp(category: Categories.categories[indexPath.row])
            
            cell.isHidden = false
            
            return cell
        case popularDishesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishCell
            
            cell.setup(withTheDish: FilteredPopular[indexPath.row])
            
            cell.isHidden = false
            //            print(FilteredPopular)
            //            print("RIGHT HERE RIGHT HERE RIGHT HERE")
            
            return cell
        case specialDishesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialDishCell", for: indexPath) as! SpecialDishCell
            
            cell.setup(specialDish: FilteredSpecial[indexPath.row])
            cell.isHidden = false
            return cell
        default:
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Haptics.selectionVibration()
        switch collectionView {
        case categoryCollectionView:
            performSegue(withIdentifier: "showList", sender: self)
        case popularDishesView:
            performSegue(withIdentifier: "showDetails", sender: self)
        case specialDishesView:
            performSegue(withIdentifier: "showDetails", sender: self)
        default:
            performSegue(withIdentifier: "showList", sender: self)
        }
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
