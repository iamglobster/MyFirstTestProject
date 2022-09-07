//
//  DetailedInfoPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - DetailedInfoPresenterProtocol
protocol DetailedInfoPresenterProtocol {
    var news: Result { get }
}

// MARK: - FavouriteNewsPresenter
class DetailedInfoPresenter: DetailedInfoPresenterProtocol {
     
    // MARK: - Properties
    private let navigator: NavigatorProtocol
    private var delegate: DetailedInfoViewControllerProtocol!
    var news: Result
    
    // MARK: - Init
    init(navigator: NavigatorProtocol, news: Result) {
        self.navigator = navigator
        self.news = news
    }
}
