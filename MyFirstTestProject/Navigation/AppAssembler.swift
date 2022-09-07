//
//  AppAssembler.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

class AppAssembler {
    
    func instantiateEmailedNewsVC(networkService: AlamofireNetworkProtocol, navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = EmailedNewsPresenter(networkService: networkService, navigator: navigator)
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
    
    func instantiateSharedNewsVC(networkService: AlamofireNetworkProtocol, navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = SharedNewsPresenter(networkService: networkService, navigator: navigator)
        let sharedNewsVC = SharedNewsViewController(presenter: presenter)
        presenter.set(delegate: sharedNewsVC)
        let navigationVC = UINavigationController(rootViewController: sharedNewsVC)
        let appearance = UINavigationBarAppearance()
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        sharedNewsVC.tabBarItem = UITabBarItem(title: "Shared",
                                               image: UIImage(systemName: "person.3"),
                                               selectedImage: UIImage(systemName: "person.3.fill"))
        
        
        return navigationVC
    }
    
    func instantiateViewedNewsVC(networkService: AlamofireNetworkProtocol, navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = ViewedNewsPresenter(networkService: networkService, navigator: navigator)
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
    
    func instantiateFavoritesNewsVC() -> UINavigationController {
        let presenter = FavoritesNewsPresenter()
        let favoritesNewsVC = FavoritesNewsViewController(presenter: presenter)
        presenter.set(delegate: favoritesNewsVC)
        let navigationVC = UINavigationController(rootViewController: favoritesNewsVC)
        let appearance = UINavigationBarAppearance()
        navigationVC.navigationBar.scrollEdgeAppearance = appearance
        
        favoritesNewsVC.tabBarItem = UITabBarItem(title: "Favorites",
                                               image: UIImage(systemName: "heart"),
                                               selectedImage: UIImage(systemName: "heart.fill"))
        
        return navigationVC
    }
    
    func instantiateDetailedInfoVC(navigator: Navigator , news: Result) -> UIViewController {
        let presenter = DetailedInfoPresenter(navigator: navigator, news: news)
        let detailedInfoVC = DetailedInfoViewController(presenter: presenter)
  
        return detailedInfoVC
    }
    
}
