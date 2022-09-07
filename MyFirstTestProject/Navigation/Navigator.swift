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
    func addInstantiateDetailedInfoVC(view: UIViewController, news: Result)
}

// MARK: - Navigator
class Navigator: NavigatorProtocol {
    
    // MARK: - Properties
    private let appAssembler = AppAssembler()
    private let networkService = AlamofireNetwork()
    
    // MARK: - Methods
    func addInstantiateEmailedNewsVC() -> UINavigationController {
        appAssembler.instantiateEmailedNewsVC(networkService: networkService, navigator: self)
    }
    
    func addInstantiateSharedNewsVC() -> UINavigationController {
        appAssembler.instantiateSharedNewsVC(networkService: networkService, navigator: self)
    }
    
    func addInstantiateViewedNewsVC() -> UINavigationController {
        appAssembler.instantiateViewedNewsVC(networkService: networkService, navigator: self)
    }
    
    func addInstantiateFavoritesNewsVC() -> UINavigationController {
        appAssembler.instantiateFavoritesNewsVC()
    }
    
    func addInstantiateDetailedInfoVC(view: UIViewController, news: Result) {
        let detailedInfo = appAssembler.instantiateDetailedInfoVC(navigator: self, news: news)
        view.navigationController?.pushViewController(detailedInfo, animated: true)
    }
}
