//
//  SharedNewsPresenter.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - SharedNewsPresenterProtocol
protocol SharedNewsPresenterProtocol {
    var news: [Result] { get }
    
    func getNews(period: Int)
    func showDetailedInfoVC(view: UIViewController, news: Result)
}

// MARK: - SharedNewsViewController
class SharedNewsPresenter: SharedNewsPresenterProtocol {
    
    // MARK: - Properties
    private let networkService: AlamofireNetworkProtocol
    private let navigator: NavigatorProtocol
    private var delegate: SharedNewsViewControllerProtocol!
    
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
    func set(delegate: SharedNewsViewControllerProtocol) {
        self.delegate = delegate
    }
    
    func getNews(period: Int) {
        networkService.getNews(with: API.getSharedNews(period).stringValue) { model in
            guard let news = model.results else { return }
            self.news = news
        }
    }
    
    func showDetailedInfoVC(view: UIViewController, news: Result) {
        navigator.addInstantiateDetailedInfoVC(view: view, news: news)
    }
}
