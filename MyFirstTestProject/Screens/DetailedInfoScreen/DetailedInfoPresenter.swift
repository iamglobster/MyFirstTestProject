//
//  DetailedInfoPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - DetailedInfoPresenterProtocol
protocol DetailedInfoPresenterProtocol {
    var news: Result { get set }

    func createNews()
}

// MARK: - FavouriteNewsPresenter
class DetailedInfoPresenter: DetailedInfoPresenterProtocol {
     
    // MARK: - Properties
    private let navigator: NavigatorProtocol
    private var delegate: DetailedInfoViewControllerProtocol!
    private let coreDataStore: CoreDataManagerProtocol

    var news: Result
    
    // MARK: - Init
    init(navigator: NavigatorProtocol, news: Result, coreDataStore: CoreDataManagerProtocol) {
        self.navigator = navigator
        self.news = news
        self.coreDataStore = coreDataStore
    }

    func createNews() {
        let news = NewsEntity(context: coreDataStore.context)
        guard let url = self.news.url else {
            return
        }
        news.titleNewsEntity = self.news.title
        news.imageNewsEntity = url
        news.id = UUID()

        coreDataStore.saveContext()
    }
}
