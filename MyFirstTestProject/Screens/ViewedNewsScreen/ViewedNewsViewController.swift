//
//  ViewedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - ViewedNewsViewControllerProtocol
protocol ViewedNewsViewControllerProtocol {
    
}

// MARK: - ViewedNewsViewController
class ViewedNewsViewController: UIViewController {

    // MARK: - Properties
    private let presenter: ViewedNewsPresenterProtocol
    
    // MARK: - Init
    init(presenter: ViewedNewsPresenterProtocol) {
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

extension ViewedNewsViewController: ViewedNewsViewControllerProtocol {
    
}
