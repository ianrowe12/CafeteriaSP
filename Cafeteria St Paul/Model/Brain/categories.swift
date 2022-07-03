
import UIKit

struct Categories {
    static var categories: [DishCategory] = [
        .init(name: "Breakfast", image: UIImage(imageLiteralResourceName: "breakfast-icon"), dishes: dishBrain.breakfast),
        .init(name: "Lunch", image: UIImage(imageLiteralResourceName: "lunch-icon"), dishes: dishBrain.lunch),
        .init(name: "Fast Dishes", image: UIImage(imageLiteralResourceName: "snacks-salados"), dishes:
            dishBrain.snackSalado
        ),
        .init(name: "Sweet Snacks", image: UIImage(imageLiteralResourceName: "snacks-dulces"), dishes: dishBrain.dessert)
    ]
}
