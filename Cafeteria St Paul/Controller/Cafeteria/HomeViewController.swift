

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var popularDishesView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var specialDishesView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Vars and constants
    var weekDay = 0
    var FilteredPopular, FilteredSpecial, FilteredLunch, FilteredBreakfast, FilteredSnackSalado, FilteredDessert: [Dish]?
    static var selectedDate = Date().addingTimeInterval(24*60*60)
    
    //MARK: - View Will Dissappear
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafeteria"
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        popularDishesView.delegate = self
        popularDishesView.dataSource = self
        
        specialDishesView.delegate = self
        specialDishesView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        datePicker.minimumDate = Date().addingTimeInterval(24*60*60) //The minumum date to pick is tomorrow.
        
        weekDay = Calendar.current.component(.weekday, from: Date().addingTimeInterval(24*60*60))
        
        registerCells()
        filterByDate()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        filterByDate()
        DispatchQueue.main.async {
            self.popularDishesView.reloadData()
            self.specialDishesView.reloadData()
        }
    }
    
    
    //MARK: - Date was changed
    
    @IBAction func dateChanged(_ sender: Any) {
        HomeViewController.selectedDate = datePicker.date
        weekDay = Calendar.current.component(.weekday, from: HomeViewController.selectedDate)
        filterByDate()
        popularDishesView.reloadData()
        specialDishesView.reloadData()
        
    }
    
    //MARK: - Variables depending on date
    func filterByDate(){
        FilteredPopular = dishBrain.popularDishes.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        FilteredSpecial = dishBrain.specialDishes.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        FilteredLunch = dishBrain.lunch.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        FilteredBreakfast = dishBrain.breakfast.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        FilteredSnackSalado = dishBrain.snackSalado.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        FilteredDessert = dishBrain.dessert.filter { dish in
            return dish.dayOfWeek.contains(weekDay)
        }
        
        //Esto es para las categorias del siguiente view
        Categories.categories[0].dishes = FilteredBreakfast!
        Categories.categories[1].dishes = FilteredLunch!
        Categories.categories[2].dishes = FilteredSnackSalado!
        Categories.categories[3].dishes = FilteredDessert!
        
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
                destinationVC.selectedDetail = FilteredPopular![indexPath.row]
            } else if let indexPath = specialDishesView.indexPathsForSelectedItems?.first{
                destinationVC.selectedDetail = FilteredSpecial![indexPath.row]
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
            return FilteredPopular!.count
        case specialDishesView:
            return FilteredSpecial!.count
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
            
            cell.setup(withTheDish: FilteredPopular![indexPath.row])
            
            cell.isHidden = false
            
            return cell
        case specialDishesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialDishCell", for: indexPath) as! SpecialDishCell
            
            cell.setup(specialDish: FilteredSpecial![indexPath.row])
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
