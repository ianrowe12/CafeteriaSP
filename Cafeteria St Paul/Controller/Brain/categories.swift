
import UIKit


struct Categories {
    static let categories: [DishCategory] = [
        .init(name: "Breakfast", image: UIImage(imageLiteralResourceName: "breakfast-icon"), dishes: [
            dishBrain.pinto, dishBrain.tortillas
        ]),
        .init(name: "Lunch", image: UIImage(imageLiteralResourceName: "lunch-icon"), dishes: [
            dishBrain.cordonBlue, dishBrain.pastelDePapa, dishBrain.lasagna, dishBrain.casado
        ]),
        .init(name: "Fast Dishes", image: UIImage(imageLiteralResourceName: "snacks-salados"), dishes: [
            dishBrain.friesNuggets, dishBrain.pizza
        ]),
        .init(name: "Sweet Snacks", image: UIImage(imageLiteralResourceName: "snacks-dulces"), dishes: [
            dishBrain.donut, dishBrain.pañuelo, dishBrain.cachito
        ])
    ]
}
