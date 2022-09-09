//
//  FavouriteNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit
import CoreData

// MARK: - FavoritesNewsPresenterProtocol
protocol FavoritesNewsPresenterProtocol {
    var news: [Result] { get set }
    
    func showDetailNewsVC(view: UIViewController, news: Result)
    func fetchItem()
    func deleteItem(id: UUID, index: Int)
}

// MARK: - FavouriteNewsPresenter
class FavoritesNewsPresenter: FavoritesNewsPresenterProtocol {
    
    // MARK: - Properties
    private let networkService: AlamofireNetworkProtocol
    private let navigator: NavigatorProtocol
    private let coreDataStore: CoreDataManagerProtocol
    private var delegate: FavoritesNewsViewControllerProtocol!
    
    var news: [Result] = [] {
        didSet {
            delegate.update(with: news, animated: true)
        }
    }
    
    // MARK: - Init
    init(networkService: AlamofireNetworkProtocol, navigator: NavigatorProtocol, coreDataStore: CoreDataManagerProtocol) {
        self.networkService = networkService
        self.navigator = navigator
        self.coreDataStore = coreDataStore
    }
    
    // MARK: - Methods
    func set(delegate: FavoritesNewsViewControllerProtocol) {
        self.delegate = delegate
    }
    
    func showDetailNewsVC(view: UIViewController, news: Result) {
        navigator.showDetailedInfoVC(view: view, news: news)
    }

    func fetchItem() {
        news = coreDataStore.fetchRequest()
    }

    func deleteItem(id: UUID, index: Int) {
        coreDataStore.deleteUsers(id: id) {
            self.news.remove(at: index)
        }
    }
}
