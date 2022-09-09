//
//  AppAssembler.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

class AppAssembler {

    private let networkService = AlamofireNetwork()
    private let coreDataStore = CoreDataManager()
    
    func instantiateEmailedNewsVC(navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = EmailedNewsPresenter(networkService: networkService, navigator: navigator)
        let emailedNewsVC = EmailedNewsViewController(presenter: presenter)
        presenter.set(delegate: emailedNewsVC)
        let navigationVC = UINavigationController(rootViewController: emailedNewsVC)
        emailedNewsVC.tabBarItem = UITabBarItem(title: "Emailed",
                                                image: UIImage(systemName: "paperplane"),
                                                selectedImage: UIImage(systemName: "paperplane.fill"))
        
        return navigationVC
    }
    
    func instantiateSharedNewsVC(navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = SharedNewsPresenter(networkService: networkService, navigator: navigator)
        let sharedNewsVC = SharedNewsViewController(presenter: presenter)
        presenter.set(delegate: sharedNewsVC)
        let navigationVC = UINavigationController(rootViewController: sharedNewsVC)
        sharedNewsVC.tabBarItem = UITabBarItem(title: "Shared",
                                               image: UIImage(systemName: "person.3"),
                                               selectedImage: UIImage(systemName: "person.3.fill"))
        
        
        return navigationVC
    }
    
    func instantiateViewedNewsVC(navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = ViewedNewsPresenter(networkService: networkService, navigator: navigator)
        let viewedNewsVC = ViewedNewsViewController(presenter: presenter)
        presenter.set(delegate: viewedNewsVC)
        let navigationVC = UINavigationController(rootViewController: viewedNewsVC)
        
        viewedNewsVC.tabBarItem = UITabBarItem(title: "Viewed",
                                               image: UIImage(systemName: "eye"),
                                               selectedImage: UIImage(systemName: "eye.fill"))
        
        return navigationVC
    }
    
    func instantiateFavoritesNewsVC(navigator: NavigatorProtocol) -> UINavigationController {
        let presenter = FavoritesNewsPresenter(networkService: networkService, navigator: navigator, coreDataStore: coreDataStore)
        let favoritesNewsVC = FavoritesNewsViewController(presenter: presenter)
        presenter.set(delegate: favoritesNewsVC)
        let navigationVC = UINavigationController(rootViewController: favoritesNewsVC)
        
        favoritesNewsVC.tabBarItem = UITabBarItem(title: "Favorites",
                                               image: UIImage(systemName: "heart"),
                                               selectedImage: UIImage(systemName: "heart.fill"))
        
        return navigationVC
    }
    
    func instantiateDetailedInfoVC(navigator: Navigator , news: Result) -> UIViewController {
        let presenter = DetailedInfoPresenter(navigator: navigator, news: news, coreDataStore: coreDataStore)
        let detailedInfoVC = DetailedInfoViewController(presenter: presenter)
  
        return detailedInfoVC
    }
    
}
