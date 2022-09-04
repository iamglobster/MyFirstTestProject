//
//  SharedNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - SharedNewsPresenterProtocol
protocol SharedNewsPresenterProtocol {
    
}

// MARK: - SharedNewsViewController
class SharedNewsPresenter: SharedNewsPresenterProtocol {
    
    // MARK: - Properties
    private var delegate: SharedNewsViewControllerProtocol!
    
    // MARK: - Methods
    func set(delegate: SharedNewsViewControllerProtocol) {
        self.delegate = delegate
    }
}
