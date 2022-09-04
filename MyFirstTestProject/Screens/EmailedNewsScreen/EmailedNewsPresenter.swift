//
//  EmailedNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - EmailedNewsPresenterProtocol
protocol EmailedNewsPresenterProtocol {
    
}

// MARK: - EmailedNewsPresenter
class EmailedNewsPresenter: EmailedNewsPresenterProtocol {
    
    // MARK: - Properties
    private var delegate: EmailedNewsViewControllerProtocol!
    
    // MARK: - Methods
    func set(delegate: EmailedNewsViewControllerProtocol) {
        self.delegate = delegate
    }
}
