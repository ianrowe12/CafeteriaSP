
import UIKit

struct welcomePages {
    static let welcomePages: [WelcomePage] = [
        .init(title: "Cafeteria Ordering App", description: "You can now skip the lines and get what you actually want by ordering from your phone.", image: UIImage(imageLiteralResourceName: "page1")),
        .init(title: "Saint Paul Students", description: "This app is meant for Saint Paul Students ONLY. If you are not part of the student body and buy something, we won't be able to refund your purchase", image: UIImage(imageLiteralResourceName: "page2")),
        .init(title: "Pick Up Date", description: "If you don't pick up your dish on your selected retrieval date, you won't be able to claim it eventually", image: UIImage(imageLiteralResourceName: "page3")),
        .init(title: "Identity", description: "Please make sure to be using your real name and carné, otherwise the waitress will have to refuse giving you your order", image: UIImage(imageLiteralResourceName: "page4"))        
    ]
}

