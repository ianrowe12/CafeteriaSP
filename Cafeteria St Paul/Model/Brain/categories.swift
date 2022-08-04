
import UIKit

struct Categories {
    static var categories: [DishCategory] = [
        .init(name: "Breakfast", image: UIImage(imageLiteralResourceName: "breakfast-icon"), dishes: []), //ESTO FUE CAMBIADO A UN EMPTY ARRAY
        .init(name: "Lunch", image: UIImage(imageLiteralResourceName: "lunch-icon"), dishes: []),
        .init(name: "Fast Dishes", image: UIImage(imageLiteralResourceName: "snacks-salados"), dishes:
            []
        ),
        .init(name: "Sweet Snacks", image: UIImage(imageLiteralResourceName: "snacks-dulces"), dishes: [])
    ]
}
