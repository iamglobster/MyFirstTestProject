//
//  DetailedInfoViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit
import CoreData

// MARK: - DetailedInfoViewControllerProtocol
protocol DetailedInfoViewControllerProtocol {
    
}

// MARK: - DetailedInfoViewController
class DetailedInfoViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var newsDetailedImageView: UIImageView!
    @IBOutlet weak var titleDetailedLabel: UILabel!
    @IBOutlet weak var favoritesNewsButton: UIButton!
    
    // MARK: - Properties
    private var presenter: DetailedInfoPresenterProtocol
    
    // MARK: - Init
    init(presenter: DetailedInfoPresenterProtocol) {
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
    
    // MARK: - Action
    @IBAction func saveNewsAction(_ sender: Any) {
        presenter.createNews()
    }
}

// MARK: - Private Extension
private extension DetailedInfoViewController {
    func setupUI() {
        setupButton()
        setupNavigationBar()
        setupNewsDetailedImageView()
    }
    
    func setupButton() {
        favoritesNewsButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        favoritesNewsButton.setTitle("SAVE", for: .normal)
        favoritesNewsButton.layer.cornerRadius = 10
        favoritesNewsButton.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.25, alpha: 0.8)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your favorites news"
    }
    
    func setupNewsDetailedImageView() {
        newsDetailedImageView.layer.cornerRadius = 10
        newsDetailedImageView.contentMode = .scaleAspectFill

        titleDetailedLabel.text = presenter.news.title
        presenter.news.media?.forEach { media in
            media.mediametadata?.forEach {
                guard let image = $0.url, let url = URL(string: image) else { return }
                self.presenter.news.url = url
                DispatchQueue.main.async {
                    self.newsDetailedImageView.kf.setImage(with: url)
                }
            }
        }
    }
}
