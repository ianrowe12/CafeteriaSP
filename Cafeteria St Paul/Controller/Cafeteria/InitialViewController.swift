//
//  InitialViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/25/22.
//

import UIKit
import Firebase
import ProgressHUD

class InitialViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        uploadDish(name: "Spaguetti con carne molida y salsa de tomate", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%201%2FspaghettiMeat.jpeg?alt=media&token=d06f9c32-c395-411a-ab22-ae83c4350db5", dates: ["29/08/2022", "10/10/2022", "21/11/2022"])
//        uploadDish(name: "Bistec encebollado", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%205%2FonionSteak.png?alt=media&token=47d37fc9-ef67-46eb-8fa1-576111664542", dates: ["30/08/2022", "11/10/2022", "22/11/2022"])
//        uploadDish(name: "Arroz con pollo", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%202%2FarrozConPollo.jpeg?alt=media&token=87afa6a4-6f20-495e-93d2-665defe97b85", dates: ["31/08/2022", "12/10/2022", "23/11/2022"])
//        uploadDish(name: "Fajitas mixtas", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Ffajitas%20mixtas.png?alt=media&token=e98fc25f-0180-417d-b359-855c5885003d", dates: ["01/09/2022", "13/10/2022", "24/11/2022"])
//        uploadDish(name: "Sopa azteca", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%204%2FsopaAzteca.jpeg?alt=media&token=e09b32fd-86f4-4fa5-a04c-e0705e10ab77", dates: ["02/09/2022", "14/10/2022", "25/11/2022"])
//        uploadDish(name: "Pollo a la plancha", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%205%2FgrilledChicken.jpg?alt=media&token=2066a9d0-9eaf-47bc-aba7-a6cebf2d63e8", dates: ["05/09/2022", "17/10/2022", "28/11/2022"])
//        uploadDish(name: "Picadillo de papa con carne", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%202%2FpicadilloPapa.jpeg?alt=media&token=d82e875d-0634-4386-ade0-76c489b78267", dates: ["06/09/2022", "18/10/2022", "29/11/2022"])
//        uploadDish(name: "Pescado empanizado y puré de papa", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%201%2FpescadoYpure.jpeg?alt=media&token=4172da11-dcd5-4ccf-8763-beeac1489bd0", dates: ["07/09/2022", "19/10/2022", "30/11/2022"])
//        uploadDish(name: "Arroz cantones y patacones", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%203%2FarrozCantones.webp?alt=media&token=a749b01c-5615-4321-8328-492d6a6f5026", dates: ["08/09/2022", "20/10/2022"])
//        uploadDish(name: "Chifrijo", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%201%2Fchifrijo.jpeg?alt=media&token=e97c07f4-fbbc-4873-87e0-89266d2acbd5", dates: ["09/09/2022", "21/10/2022"])
//        uploadDish(name: "Pollo con papa", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%201%2FchickenPotato.jpeg?alt=media&token=2f51a10c-77ba-4a78-bbce-5878c352023e", dates: ["12/09/2022", "24/10/2022"])
//        uploadDish(name: "Pasta en salsa blanca", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%204%2FspaghettiSalsaBlanca.jpeg?alt=media&token=9303c58d-e19d-4287-87ed-49920eb3ca31",description: "Includes ham and/or chicken. Photographs are illustrative only and do not depict the exact product", dates: ["13/09/2022", "25/10/2022"])
//        uploadDish(name: "Pastel de papa con carne molida", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%203%2FpastelDePapa.jpeg?alt=media&token=d3a8d9eb-a036-41c2-95c6-c9d9710d8390", dates: ["14/09/2022", "26/10/2022"])
//        uploadDish(name: "Carne en salsa de tomate", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%201%2FcarneEnSalsa.jpeg?alt=media&token=ab0b887a-558b-4140-9a4b-7fb9b889c76f", dates: ["15/09/2022", "27/10/2022"])
//        uploadDish(name: "Dedos de pollo con papas", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Fdedos%20de%20pollo%20y%20papas.png?alt=media&token=49320625-4ce6-4b14-92e3-678650d6bd6e", dates: ["16/09/2022", "28/10/2022"])
//        uploadDish(name: "Tortas de Carne", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Ftortas%20de%20carne.png?alt=media&token=39ded553-7b97-46d8-a329-1043a9796d6a",description: "Includes rice, beans and salad. Photographs are illustrative only and do not depict the exact product", dates: ["08/08/2022", "19/09/2022", "31/10/2022"])
//        uploadDish(name: "Cordon Blue y puré de papa", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%203%2FcordonBlue.jpeg?alt=media&token=6edf4d60-086b-43a3-ac05-63291be0a8b8", dates: ["09/08/2022", "20/09/2022", "01/11/2022"])
//        uploadDish(name: "Canelones con carne molida", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%204%2Fcanelones.jpeg?alt=media&token=16fa6961-f1a4-44f4-8d02-2dcee78d5252", dates: ["10/08/2022", "21/09/2022", "02/11/2022"])
//        uploadDish(name: "Cerdo y yuca frita", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Fcerdo%20y%20yuca.png?alt=media&token=68b0fb1f-cab9-4170-87dc-1c7f149bf0de", dates: ["11/08/2022", "22/09/2022", "03/11/2022"])
//        uploadDish(name: "Nachos", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%202%2FNachos.jpeg?alt=media&token=24cc9a9e-b0df-4efb-9e71-985947b8d065", dates: ["12/08/2022", "23/09/2022", "04/11/2022"])
//        uploadDish(name: "Pollo en salsa de tomate", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Fcerdo%20y%20yuca.png?alt=media&token=68b0fb1f-cab9-4170-87dc-1c7f149bf0de", dates: ["15/08/2022", "26/09/2022", "07/11/2022"])
//        uploadDish(name: "Lasaña de carne molida", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%202%2Flasan%CC%83a.jpeg?alt=media&token=6cf81c91-fe6e-4e68-bd11-e8d677610fda", dates: ["16/08/2022", "27/09/2022", "08/11/2022"])
//        uploadDish(name: "Chuleta", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%204%2FChuleta.jpeg?alt=media&token=046d9e2d-a400-41a0-8a3e-9fbea0142d28", dates: ["17/08/2022", "28/09/2022", "09/11/2022"])
//        uploadDish(name: "Pollo en salsa blanca", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%202%2FpolloSalsaBlanca.jpeg?alt=media&token=ddbe9f08-2b68-4bfc-9c9b-263fa3f80570", dates: ["18/08/2022", "29/09/2022", "10/11/2022"])
//        uploadDish(name: "Hamburguesa", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%205%2FHamburger.jpeg?alt=media&token=330e9d1a-206f-40f9-b7c2-a40bafbf0d53", dates: ["19/08/2022", "30/09/2022", "11/11/2022"])
//        uploadDish(name: "Pollo a la plancha", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%205%2FgrilledChicken.jpg?alt=media&token=2066a9d0-9eaf-47bc-aba7-a6cebf2d63e8", dates: ["22/08/2022", "03/10/2022", "14/11/2022"])
//        uploadDish(name: "Picadillo de plátano verde con carne", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%206%2FpicadilloPlatano.jpeg?alt=media&token=207f06ec-f19a-42cd-9318-eef15acefd44", dates: ["23/08/2022", "04/10/2022", "15/11/2022"])
//        uploadDish(name: "Chop Suey", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FPlatillos%20nuevos%201%2Fchop%20suey.png?alt=media&token=abc0e084-0f18-4485-a355-d02fa143623d", dates: ["24/08/2022", "05/10/2022", "16/11/2022"])
//        uploadDish(name: "Garbanzos con costilla de cerdo", imageURL: "https://firebasestorage.googleapis.com/v0/b/cafeteria-st-paul.appspot.com/o/Almuerzos%2FSemana%206%2FgarbanzosCostilla.jpeg?alt=media&token=f35409de-bda7-4a3f-b2d3-bee8435d3784", dates: ["25/08/2022", "06/10/2022", "17/11/2022"])
//        uploadDish(name: "Alitas fritas y ceviche de Plátano", imageURL: "Alitas fritas y ceviche de Banano", dates: ["26/08/2022", "07/10/2022", "18/11/2022"])
//
//    }
//
//    func uploadDish(name: String, imageURL: String, description: String = "Photographs are illustrative only and do not depict the exact product", dates: [String]) {
//            db.collection("Dishes").document("All").collection("Lunch").document(name).setData([
//                "Description" : description,
//                "imageURL" : imageURL,
//                "name" : name,
//                "price" : "₡3000",
//                "dates" : dates
//            ]) {error in
//                if error != nil {
//                    ProgressHUD.showError(error?.localizedDescription)
//                } else {
//                    ProgressHUD.showSuccess()
//                }
//            }
//        }
        
        /*
        func addType(collection: String, type: String) {
            
            db.collection("Dishes").document("All").collection(collection).getDocuments { querySnapshot, error in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                } else {
                    if let firestoreDocs = querySnapshot?.documents {
                        for doc in firestoreDocs {
                            var id = doc.documentID
                            self.db.collection("Dishes").document("All").collection(collection).document(id).setData([
                                "type" : type
                            ], merge: true)
                        }
                    }
                }
            }
        } */
    }

    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) { // Just before the view appears
        super.viewWillAppear(animated) // when overriding, you must call super at some point
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) { // just before the view changes
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 10
        createAccountButton.layer.cornerRadius = 10
    }
    

}
