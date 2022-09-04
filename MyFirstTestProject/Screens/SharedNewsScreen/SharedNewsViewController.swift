//
//  SharedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - SharedNewsViewControllerProtocol
protocol SharedNewsViewControllerProtocol {
    
}

// MARK: - SharedNewsViewController
class SharedNewsViewController: UIViewController {

    // MARK: - Properties
    private let presenter: SharedNewsPresenterProtocol
    
    // MARK: - Init
    init(presenter: SharedNewsPresenterProtocol) {
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

extension SharedNewsViewController: SharedNewsViewControllerProtocol {
    
}
