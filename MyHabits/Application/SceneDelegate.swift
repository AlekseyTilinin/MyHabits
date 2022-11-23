//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Aleksey on 08.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var habitsTabNavigationController : UINavigationController!
    var infoTabNavigationControoller : UINavigationController!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        habitsTabNavigationController = UINavigationController.init(rootViewController: HabitsViewController())
        infoTabNavigationControoller = UINavigationController.init(rootViewController: InfoViewController())
        
        tabBarController.viewControllers = [habitsTabNavigationController, infoTabNavigationControoller]
        
        let habitsItem = UITabBarItem(title: "Привычки", image: UIImage(named: "Shape"), tag: 0)
        let infoItem = UITabBarItem(title: "Информация", image:  UIImage(systemName: "info.circle.fill"), tag: 1)
        
        habitsTabNavigationController.tabBarItem = habitsItem
        infoTabNavigationControoller.tabBarItem = infoItem
        
        UITabBar.appearance().tintColor = habitColorPurple
        UITabBar.appearance().backgroundColor = .systemBackground
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}

