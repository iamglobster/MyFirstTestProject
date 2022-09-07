//
//  FlowViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 03.09.2022.
//

import UIKit

// MARK: - FlowViewController
class FlowViewController: UIViewController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private let tabBarVC = UITabBarController()
    private let navigator = Navigator()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarVC()
    }
}

// MARK: - Private Extension
private extension FlowViewController {
    func setupTabBarVC() {
        
        view.backgroundColor = .white
        
        let appearance = tabBarVC.tabBar.standardAppearance
        appearance.shadowColor = .gray
        
        if #available(iOS 15.0, *) {
            tabBarVC.tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBarVC.tabBar.standardAppearance = appearance
        }
        
        let emailedNewsVC = navigator.addInstantiateEmailedNewsVC()
        let sharedNewsVC = navigator.addInstantiateSharedNewsVC()
        let viewedNewsVC = navigator.addInstantiateViewedNewsVC()
        let favoritesVC = navigator.addInstantiateFavoritesNewsVC()
        
        tabBarVC.delegate = self
        tabBarVC.viewControllers = [emailedNewsVC, sharedNewsVC, viewedNewsVC, favoritesVC]
        tabBarVC.tabBar.tintColor = .black
        
        addChild(tabBarVC, toContainer: view)
        
    }
    
}

