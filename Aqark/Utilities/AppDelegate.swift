//
//  AppDelegate.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/10/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Override point for customization after application launch.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureFirebase()
        configureGoogleMap()
        configureInAppPurchase()
        setLaunchView()
        setHomeView()
        return true
    }
    
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Aqark")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


extension AppDelegate {
    
    private func configureFirebase() {
        FirebaseApp.configure()
    }
    
    private func configureGoogleMap() {
        GMSPlacesClient.provideAPIKey("AIzaSyBcAep0YORoUFFlmvyyE-QzwhkUkPDl5bM")
    }
    
    private func configureInAppPurchase() {
        PurchaseManager.instance.fetchProducts()
    }
    
    private func setLaunchView() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let launchScreen = LaunchViewController()
        window?.rootViewController = launchScreen
    }
    
    private func setHomeView() {
        let date = Date().addingTimeInterval(5)
        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(startApp), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc private func startApp() {
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = Theme.Color.primary
        tabBarController.tabBar.tintColor = Theme.Color.selectionColor
        
        let searchTab = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchTab)
        searchNavigationController.navigationBar.barTintColor = Theme.Color.primary
        searchNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Theme.Color.headerTextColor]
        searchTab.tabBarItem = UITabBarItem(title: "Search".localize, image: UIImage(named: "search"), tag: 1)
        
        let accountTab = LoginViewController()
        let accountNavigationController = UINavigationController(rootViewController: accountTab)
        accountNavigationController.navigationBar.barTintColor = Theme.Color.primary
        accountNavigationController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor :  Theme.Color.headerTextColor]
        accountTab.tabBarItem = UITabBarItem(title: "Account".localize, image: UIImage(named: "profile"), tag: 2)
        
        let favouriteTab = FavouriteViewController()
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteTab)
        favouriteNavigationController.navigationBar.barTintColor = Theme.Color.primary
        favouriteNavigationController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor :  Theme.Color.headerTextColor]
        favouriteTab.tabBarItem = UITabBarItem(title: "Favourite".localize, image: UIImage(named: "heart"), tag: 3)
        
        
        let controllers = [searchNavigationController,
                           favouriteNavigationController,
                           accountNavigationController]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
    }
}

