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
}

// MARK: - Navigator
class Navigator: NavigatorProtocol {
    
    // MARK: - Properties
    private let appAssembler = AppAssembler()
    
    // MARK: - Methods
    func addInstantiateEmailedNewsVC() -> UINavigationController {
        appAssembler.instantiateEmailedNewsVC()
    }
    
    func addInstantiateSharedNewsVC() -> UINavigationController {
        appAssembler.instantiateSharedNewsVC()
    }
    
    func addInstantiateViewedNewsVC() -> UINavigationController {
        appAssembler.instantiateViewedNewsVC()
    }
}
