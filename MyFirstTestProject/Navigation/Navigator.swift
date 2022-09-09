//
//  Navigator.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - NavigatorProtocol
protocol NavigatorProtocol {
    func addInstantiateEmailedNewsVC() -> UINavigationController
    func addInstantiateSharedNewsVC() -> UINavigationController
    func addInstantiateViewedNewsVC() -> UINavigationController
    func addInstantiateFavoritesNewsVC() -> UINavigationController
    func showDetailedInfoVC(view: UIViewController, news: Result)
}

// MARK: - Navigator
class Navigator: NavigatorProtocol {
    
    // MARK: - Properties
    private let appAssembler = AppAssembler()
   
    
    // MARK: - Methods
    func addInstantiateEmailedNewsVC() -> UINavigationController {
        appAssembler.instantiateEmailedNewsVC(navigator: self)
    }
    
    func addInstantiateSharedNewsVC() -> UINavigationController {
        appAssembler.instantiateSharedNewsVC(navigator: self)
    }
    
    func addInstantiateViewedNewsVC() -> UINavigationController {
        appAssembler.instantiateViewedNewsVC(navigator: self)
    }
    
    func addInstantiateFavoritesNewsVC() -> UINavigationController {
        appAssembler.instantiateFavoritesNewsVC(navigator: self)
    }
    
    func showDetailedInfoVC(view: UIViewController, news: Result) {
        let detailedInfo = appAssembler.instantiateDetailedInfoVC(navigator: self, news: news)
        view.navigationController?.pushViewController(detailedInfo, animated: true)
    }
}
