//
//  EmailedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - EmailedNewsViewControllerProtocol
protocol EmailedNewsViewControllerProtocol {
    
}

// MARK: - EmailedNewsViewController
class EmailedNewsViewController: UIViewController {

    // MARK: - Properties
    private let presenter: EmailedNewsPresenterProtocol
    
    // MARK: - Init
    init(presenter: EmailedNewsPresenterProtocol) {
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

extension EmailedNewsViewController: EmailedNewsViewControllerProtocol {
    
}
