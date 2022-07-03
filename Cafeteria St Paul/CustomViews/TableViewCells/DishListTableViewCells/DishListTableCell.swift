//
//  DishListTableCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit

class DishListTableCell: UITableViewCell {

    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellPrice: UILabel!
    
    func setup(dish: Dish){
        cellTitle.text = dish.name
        cellPrice.text = dish.price
        cellImage.image = dish.image
    }
    
}
