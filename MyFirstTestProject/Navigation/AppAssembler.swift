//
//  AppAssembler.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

class AppAssembler {
    
    func instantiateEmailedNewsVC() -> UINavigationController {
        let presenter = EmailedNewsPresenter()
        let emailedNewsVC = EmailedNewsViewController(presenter: presenter)
        presenter.set(delegate: emailedNewsVC)
        let navigationVC = UINavigationController(rootViewController: emailedNewsVC)
        let appearance = UINavigationBarAppearance()
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        
        emailedNewsVC.tabBarItem = UITabBarItem(title: "Emailed",
                                                image: UIImage(systemName: "paperplane"),
                                                selectedImage: UIImage(systemName: "paperplane.fill"))
        
        return navigationVC
    }
    
    func instantiateSharedNewsVC() -> UINavigationController {
        let presenter = SharedNewsPresenter()
        let sharedNewsVC = SharedNewsViewController(presenter: presenter)
        presenter.set(delegate: sharedNewsVC)
        let navigationVC = UINavigationController(rootViewController: sharedNewsVC)
        let appearance = UINavigationBarAppearance()
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        
        sharedNewsVC.tabBarItem = UITabBarItem(title: "Shared",
                                               image: UIImage(systemName: "person.3.sequence"),
                                               selectedImage: UIImage(systemName: "person.3.fill"))
        
        return navigationVC
    }
    
    func instantiateViewedNewsVC() -> UINavigationController {
        let presenter = ViewedNewsPresenter()
        let viewedNewsVC = ViewedNewsViewController(presenter: presenter)
        presenter.set(delegate: viewedNewsVC)
        let navigationVC = UINavigationController(rootViewController: viewedNewsVC)
        let appearance = UINavigationBarAppearance()
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        
        viewedNewsVC.tabBarItem = UITabBarItem(title: "Viewed",
                                               image: UIImage(systemName: "eye"),
                                               selectedImage: UIImage(systemName: "eye.fill"))
        
        return navigationVC
    }
    
}
