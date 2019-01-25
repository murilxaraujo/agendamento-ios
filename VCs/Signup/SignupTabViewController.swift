//
//  SignupTabViewController.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 30/11/18.
//  Copyright © 2018 MRibeiro Comunicação. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBarViewController
import MaterialComponents.MDCTabBar

class SignupTabViewController: MDCTabBarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTabBar()
    }
    
    func loadTabBar() {
        let firstVC = SignUpPFViewController()
        firstVC.tabBarItem = UITabBarItem(title: "Pessoa física", image: UIImage(named: "round_person_black_24pt"), selectedImage: UIImage(named: "round_person_black_24pt"))
        
        let secondVC = SignUpPJViewController()
        secondVC.tabBarItem = UITabBarItem(title: "Pessoa jurídica", image: UIImage(named: "round_account_balance_black_24pt"), selectedImage: UIImage(named: "round_account_balance_black_24pt"))
        
        let viewControllersArray = [firstVC, secondVC]
        viewControllers = viewControllersArray
        
        let childvc = viewControllers.first
        selectedViewController = childvc
        
        tabBar?.delegate = self
        tabBar?.items = [firstVC.tabBarItem, secondVC.tabBarItem]
        
        tabBar?.selectedItem = tabBar?.items.first
        
        tabBar?.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        tabBar?.selectedItemTintColor = .white
        tabBar?.unselectedItemTintColor = .white
        
    }
    
    

}
