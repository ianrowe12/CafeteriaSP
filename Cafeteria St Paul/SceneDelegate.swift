//
//  SceneDelegate.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 8/13/21.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    static var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        SceneDelegate.window = UIWindow(windowScene: scene)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var controller: UIViewController!
        
        //        Auth.auth().addStateDidChangeListener { <#Auth#>, <#User?#> in
        //            <#code#>
        //        }
        //        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
        //            if user != nil && UserDefaults.standard.bool(forKey: "wantsSessionPersistence") == true {
        //                controller = storyBoard.instantiateViewController(withIdentifier: "homeTabController") as! UITabBarController
        //            } else {
        //                if UserDefaults.standard.notFirstTime {
        //                    controller = storyBoard.instantiateViewController(withIdentifier: "firstNav") as! UINavigationController
        //                } else {
        //                    controller = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        //                }
        //            }
        //        }
        
        
        if UserDefaults.standard.notFirstTime {
            if UserDefaults.standard.bool(forKey: "wantsSessionPersistence") == true {
                controller = storyBoard.instantiateViewController(withIdentifier: "homeTabController") as! UITabBarController
            } else {
                controller = storyBoard.instantiateViewController(withIdentifier: "firstNav") as! UINavigationController
            }
        } else {
            controller = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        }
        
        if UserDefaults.standard.object(forKey: "darkMode") == nil {
            UserDefaults.standard.setValue(false, forKey: "darkMode")
        }
        
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            SceneDelegate.window?.overrideUserInterfaceStyle = .dark
        } else {
            SceneDelegate.window?.overrideUserInterfaceStyle = .light
        }
        
        
        
        SceneDelegate.window?.rootViewController = controller
        SceneDelegate.window?.makeKeyAndVisible()
        //SceneDelegate.window?.overrideUserInterfaceStyle = .light
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}
