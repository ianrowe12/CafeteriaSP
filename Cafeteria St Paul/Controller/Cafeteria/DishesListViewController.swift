//
//  DishesListViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit

class DishesListViewController: UIViewController {
    
    var currentCategory: DishCategory? 
    
    
    @IBOutlet weak var dishesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesTableView.dataSource = self
        dishesTableView.delegate = self
        registerCell()
        title = currentCategory?.name
        self.dishesTableView.contentInsetAdjustmentBehavior = .never
        
    }
    
    
    func registerCell(){
    dishesTableView.register(UINib(nibName: "DishListTableCell", bundle: nil), forCellReuseIdentifier: "DishListTableCell")
    }
    //MARK: - Preparación para enviar los datos actuales a la siguiente pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DishDetailViewController
        if let indexPath = dishesTableView.indexPathForSelectedRow {
            destinationVC.selectedDetail = currentCategory?.dishes[indexPath.row]
        }
    }

}

    //MARK: - Métodos del TableView

extension DishesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCategory!.dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: "DishListTableCell", for: indexPath) as! DishListTableCell
        cell.setup(dish: currentCategory!.dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Haptics.selectionVibration()
        self.performSegue(withIdentifier: "showDetails", sender: self)
        dishesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
