//
//  FavouriteNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - FavoritesNewsViewControllerProtocol
protocol FavoritesNewsViewControllerProtocol {
    
}

// MARK: - FavoritesNewsViewController
class FavoritesNewsViewController: UIViewController {

    // MARK: - Properties
    private let presenter: FavoritesNewsPresenterProtocol
    
    // MARK: - Init
    init(presenter: FavoritesNewsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension FavoritesNewsViewController: FavoritesNewsViewControllerProtocol {
    
}
