//
//  EmailedNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - EmailedNewsPresenterProtocol
protocol EmailedNewsPresenterProtocol {
    var news: [Result] { get }
    
    func getNews(period: Int)
    func showDetailedInfoVC(view: UIViewController, news: Result)
}

// MARK: - EmailedNewsPresenter
class EmailedNewsPresenter: EmailedNewsPresenterProtocol {
    
    // MARK: - Properties
    private let networkService: AlamofireNetworkProtocol
    private let navigator: NavigatorProtocol
    private var delegate: EmailedNewsViewControllerProtocol!
    
    var news: [Result] = [] {
        didSet {
            delegate.update(with: news, animated: true)
        }
    }
    
    // MARK: - Init
    init(networkService: AlamofireNetworkProtocol, navigator: NavigatorProtocol) {
        self.networkService = networkService
        self.navigator = navigator
    }
    
    // MARK: - Methods
    func set(delegate: EmailedNewsViewControllerProtocol) {
        self.delegate = delegate
    }
    
    func getNews(period: Int) {
        networkService.getNews(with: API.getEmailedNews(period).stringValue) { (model: News) in
            guard let news = model.results else { return }
            self.news = news
        }
    }

    func showDetailedInfoVC(view: UIViewController, news: Result) {
        navigator.showDetailedInfoVC(view: view, news: news)
    }
}
