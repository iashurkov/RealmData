//
//  SceneDelegate.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import UIKit

protocol SceneDelegateInput: AnyObject {
    func setStartScreen()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, TransitionModel {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let rootViewController = SplashScreenAssembly.assembleModule(with: self)
        
        self.window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        self.window?.windowScene = windowsScene
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
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

// MARK: - AppDelegateInput

extension SceneDelegate: SceneDelegateInput { 
    
    func setStartScreen() {
        // First tab : News
        let newsScreenModel = NewsScreenAssembly.Model()
        let newsScreenViewController = NewsScreenAssembly.assembleModule(with: newsScreenModel)
        let newsScreenNavigationController = UINavigationController(rootViewController: newsScreenViewController)
        
        // Second tab : Favorites
        let favoritesScreenModel = FavoritesScreenAssembly.Model()
        let favoritesScreenViewController = FavoritesScreenAssembly.assembleModule(with: favoritesScreenModel)
        let favoritesScreenNavigationController = UINavigationController(rootViewController: favoritesScreenViewController)
        
        // Setting tab bar controller
        let tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([newsScreenNavigationController,
                                             favoritesScreenNavigationController], animated: false)
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.tintColor = Colors.blue
        tabBarController.tabBar.backgroundColor = Colors.gray
        
        // Setting tab bar items
        guard let tabBarItems = tabBarController.tabBar.items else { return }
        
        let titleTabBarItems = [Constant.NewsTabBarItem.title,
                                Constant.FavoritesTabBarItem.title]
        let imageTabBarItems = [Constant.NewsTabBarItem.nameImage,
                                Constant.FavoritesTabBarItem.nameImage]
        let selectedImageTabBarItems = [Constant.NewsTabBarItem.nameSelectedImage,
                                        Constant.FavoritesTabBarItem.nameSelectedImage]
        
        for id in 0..<tabBarItems.count {
            tabBarItems[id].title = titleTabBarItems[id]
            tabBarItems[id].image = UIImage.init(systemName: imageTabBarItems[id])
            tabBarItems[id].selectedImage = UIImage.init(systemName: selectedImageTabBarItems[id])
        }
        
        // Showing tab bar controller
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}
