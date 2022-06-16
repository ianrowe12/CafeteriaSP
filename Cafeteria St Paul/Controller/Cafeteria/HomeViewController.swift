//
//  HomeViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/25/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var popularDishesView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var specialDishesView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var weekDay = 0
    
    
    //MARK: - View Will Dissappear
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        popularDishesView.delegate = self
        popularDishesView.dataSource = self
        
        specialDishesView.delegate = self
        specialDishesView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        datePicker.minimumDate = Date().addingTimeInterval(24*60*60)
        
        weekDay = Calendar.current.component(.weekday, from: Date())
        
        registerCells()
        title = "Cafeteria"
        //filterPopularDays()
        
    }
    
    
    //MARK: - Date was changed
    
    @IBAction func dateChanged(_ sender: Any) {
        let selectedDate = datePicker.date
        weekDay = Calendar.current.component(.weekday, from: selectedDate)
    }
    
    //MARK: - Variables depending on date
    func filterPopularDays(){
        let mondayFilteredPopular = PopularDishes.popularDishes.filter { dish in
            return dish.dayOfWeek.contains(2)
        }
        //let tuesdayFilteredPopular = 
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
                destinationVC.selectedDetail = PopularDishes.popularDishes[indexPath.row]
            } else if let indexPath = specialDishesView.indexPathsForSelectedItems?.first{
                destinationVC.selectedDetail = SpecialDishes.specialDishes[indexPath.row]
            }
        } else {
            let destinationVC = segue.destination as! DishesListViewController
            if let indexPath = categoryCollectionView.indexPathsForSelectedItems?.first {
                destinationVC.currentCategory = Categories.categories[indexPath.row]
            }
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
            return PopularDishes.popularDishes.count
        case specialDishesView:
            return SpecialDishes.specialDishes.count
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
            
            cell.setup(withTheDish: PopularDishes.popularDishes[indexPath.row])
            
            cell.isHidden = false
            
            return cell
        case specialDishesView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialDishCell", for: indexPath) as! SpecialDishCell
            
            cell.setup(specialDish: SpecialDishes.specialDishes[indexPath.row])
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
