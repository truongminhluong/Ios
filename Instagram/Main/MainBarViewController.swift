//
//  MainBarViewController.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import UIKit

class MainBarViewController: UITabBarController {
    
    let v1: UIViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        return viewController
    }()
    
    let v2: UIViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExploreViewController")
        return viewController
    }()
    
    let v3: UIViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostViewController")
        return viewController
    }()
    
    let v4: UIViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController")
        return viewController
    }()
    
    let v5: UIViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarColor()
        setUpViewControllers()
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = .white
        navigationController?.navigationBar.barTintColor = .black
    }
    
    func setStatusBarColor(color: UIColor? = .black){
        if #available(iOS 13.0, *) {
            
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            
        } else {
            
        }
    }
    
    func setUpViewControllers() {
        let navigation1 = UINavigationController(rootViewController: v1)
        navigation1.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "Home 1"), selectedImage: UIImage(named: "Home (Filled)"))
        
        let navigation2 = UINavigationController(rootViewController: v2)
        navigation2.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "Search (Filled)"))
        
        let navigation3 = UINavigationController(rootViewController: v3)
        navigation3.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "Create"), selectedImage: UIImage(named: "Create (Filled)"))
        
        let navigation4 = UINavigationController(rootViewController: v4)
        navigation4.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "Reels"), selectedImage: UIImage(named: "Reels (Filled)"))
        
        let navigation5 = UINavigationController(rootViewController: v5)
        navigation5.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "Profile 1"), selectedImage: UIImage(named: "Profile (Filled)"))
        
        self.tabBar.tintColor = UIColor.blue
        self.viewControllers = [navigation1, navigation2, navigation3, navigation4, navigation5]
    }
    
    
    
}
