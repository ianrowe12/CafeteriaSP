
import UIKit

struct D {
    static let cordonBlue = Dish(name: "Cordon Bleu", image: UIImage(imageLiteralResourceName: "cordonBleu"), price: "₡3500", description: "Breaded chicken and ham wrapped around meat", dayOfWeek: [2])
    static let pastelDePapa = Dish(name: "Pastel de Papa", image: UIImage(imageLiteralResourceName: "pastelDePapa"), price: "₡3500", description: "Ground beef with potato and cheese", dayOfWeek: [4])
    static let lasagna = Dish(name: "Lasagna Bolognese ", image: UIImage(imageLiteralResourceName: "lasaña"), price: "₡3500", description: "Wide strips of pasta cooked and layered with meat, cheese and tomato sauce", dayOfWeek: [5])
    static let casado = Dish(name: "Casado", image: UIImage(imageLiteralResourceName: "Casado"), price: "₡3000", description: "It has rice, beans, salad and one meat type", dayOfWeek: [2, 3, 4])
    static let friesNuggets = Dish(name: "Fries & Nuggets", image: UIImage(imageLiteralResourceName: "Fries"), price: "₡2000", description: "It has french fries with 4 nuggets", dayOfWeek: [3, 4, 5, 6])
    static let pizza = Dish(name: "Pizza", image: UIImage(imageLiteralResourceName: "Pizza"), price: "₡2000", description: "One pizza slice with peperoni and tomato sauce", dayOfWeek: [4, 5, 6])
    static let galloPinto = Dish(name: "Gallo Pinto", image: UIImage(imageLiteralResourceName: "galloPinto"), price: "₡2000", description: "Black beans, salsa lizano, red bell pepper, cooked rice, garlic", dayOfWeek: [2, 3, 4, 5, 6])
    static let tortillaConNatilla = Dish(name: "Tortilla con Natilla", image: UIImage(imageLiteralResourceName: "tortillaConNatilla"), price: "₡2000", description: "Corn tortilla with custard.", dayOfWeek: [2, 3, 4, 5, 6])
    static let donuts = Dish(name: "Donuts", image: UIImage(imageLiteralResourceName: "donuts"), price: "₡600", description: "Chocolate and Vanilla Donuts", dayOfWeek: [5, 6])
    static let pañuelos = Dish(name: "Pañuelos", image: UIImage(imageLiteralResourceName: "pañuelos"), price: "₡700", description: "Puff pastry combined with the sweet flavor of the stuffed arequipe", dayOfWeek: [4, 5, 6])
    static let cachitos = Dish(name: "Cachitos", image: UIImage(imageLiteralResourceName: "cachitos"), price: "₡600", description: "It consists of a soft dough filled with delicacy, pastry cream or with chocolate cream", dayOfWeek: [2, 5, 6])
}


// IF NEW DISHES ARE ADDED, THEY MUST BE INCLUDED IN THE DishDictionary AS WELL
