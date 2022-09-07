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
        setupUI()
    }

}

// MARK: - Private Extension
private extension FavoritesNewsViewController {
    
    func setupUI() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your favorites news"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.25, alpha: 0.8)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - Extension
extension FavoritesNewsViewController: FavoritesNewsViewControllerProtocol {
    
}
