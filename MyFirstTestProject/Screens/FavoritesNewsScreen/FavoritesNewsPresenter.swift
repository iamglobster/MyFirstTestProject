//
//  FavouriteNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - FavoritesNewsPresenterProtocol
protocol FavoritesNewsPresenterProtocol {
    
}

// MARK: - FavouriteNewsPresenter
class FavoritesNewsPresenter: FavoritesNewsPresenterProtocol {
    
    // MARK: - Properties
    private var delegate: FavoritesNewsViewControllerProtocol!
    
    // MARK: - Methods
    func set(delegate: FavoritesNewsViewControllerProtocol) {
        self.delegate = delegate
    }
}
