//
//  ViewedNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - ViewedNewsPresenterProtocol
protocol ViewedNewsPresenterProtocol {
    
}

// MARK: - EmailedNewsPresenter
class ViewedNewsPresenter: ViewedNewsPresenterProtocol {
    
    // MARK: - Properties
    private var delegate: ViewedNewsViewControllerProtocol!
    
    // MARK: - Methods
    func set(delegate: ViewedNewsViewControllerProtocol) {
        self.delegate = delegate
    }
}
