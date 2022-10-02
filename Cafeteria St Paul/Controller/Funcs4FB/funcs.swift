import Foundation
import Firebase
import ProgressHUD

let db = Firestore.firestore()
struct Func {
    
    static func bringArray(whichArray: String, completionHandler:@escaping([String]) -> Void) {
        
        
        
        db.collection("Dishes").document(whichArray).getDocument { docSnapshot, error in
            if error != nil {
                ProgressHUD.showError("Error showing dishes available.")
            } else {
                if let firestoreDocument = docSnapshot {
                    
                    let data = firestoreDocument.data()
                    if let array = data!["dishes"] as? [String] {
                        completionHandler (array)
                    }
                    
                }
            }
        }
        
    }
}
