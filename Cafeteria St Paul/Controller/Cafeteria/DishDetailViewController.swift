//
//  DishDetailViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit

class DishDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var dishDetailTitle: UILabel!
    @IBOutlet weak var dishDetailPrice: UILabel!
    @IBOutlet weak var dishDetailDescription: UILabel!
    

    var selectedDetail: Dish?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setup(with: selectedDetail!)
        
    }
    
    func setup(with Dish: Dish){
        detailImage.image = Dish.image
        dishDetailTitle.text = Dish.name
        dishDetailPrice.text = Dish.price
        dishDetailDescription.text = Dish.description
    }
    
    @IBAction func purchaseTapped(_ sender: Any) {
    }
    
}
