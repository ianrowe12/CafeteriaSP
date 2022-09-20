
import UIKit

struct welcomePages {
    static let welcomePages: [WelcomePage] = [
        .init(title: "Cafeteria Ordering App", description: "You can now skip the lines and get what you actually want by ordering from your phone.", image: UIImage(imageLiteralResourceName: "page1")),
        .init(title: "Saint Paul Students", description: "You are commiting to the new school regulation by accepting that every order that you make has to be paid; if not, you can be sanctioned.", image: UIImage(imageLiteralResourceName: "page2")),
        .init(title: "Pick Up Date", description: "You are required to pick up and pay your dish on your selected retrieval date.", image: UIImage(imageLiteralResourceName: "page3")),
        .init(title: "Identity", description: "Depending on the situation, the waitress may require you to show your id or carné", image: UIImage(imageLiteralResourceName: "page4"))        
    ]
}

