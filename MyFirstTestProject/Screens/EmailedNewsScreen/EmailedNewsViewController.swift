//
//  EmailedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - EmailedNewsViewControllerProtocol
protocol EmailedNewsViewControllerProtocol {
    func update(with models: [Result], animated: Bool)
}

// MARK: - EmailedNewsViewController
class EmailedNewsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var emailedCollectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var dataSource = configureDataSource()
    private let presenter: EmailedNewsPresenterProtocol
    private var cellType: String = String(describing: NewsCell.self)
    
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
        setupUI()
        view.showActivityIndicator()
        presenter.getNews(period: 30)
    }
}

// MARK: - Private Extension
private extension EmailedNewsViewController {
    
    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Emailed news"
    }
    
    func setupCollectionView() {
        emailedCollectionView.delegate = self
        emailedCollectionView.dataSource = dataSource
        emailedCollectionView.register(.init(nibName: cellType, bundle: nil), forCellWithReuseIdentifier: cellType)
        
        emailedCollectionView.collectionViewLayout = createLayout()
        emailedCollectionView.showsHorizontalScrollIndicator = false
        emailedCollectionView.isPagingEnabled = true
    }
    
    func animateOpacity() {
        emailedCollectionView.layer.opacity = 0
        UIView.animate(withDuration: 0.5) {
            self.emailedCollectionView.layer.opacity = 1
        }
    }
    
    func alreadyGetNews() {
        animateOpacity()
        view.hideActivityIndicatorView()
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension EmailedNewsViewController {
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Int, Result> {
        let dataSource = UICollectionViewDiffableDataSource<Int, Result>(
            collectionView: emailedCollectionView) { collectionView, indexPath, model in
                (collectionView.dequeueReusableCell(withReuseIdentifier: self.cellType, for: indexPath) as? NewsCell)?.config(with: model)
            }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension EmailedNewsViewController: EmailedNewsViewControllerProtocol, UICollectionViewDelegate {
    
    func update(with models: [Result], animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            var snapshot = NSDiffableDataSourceSnapshot<Int, Result>()
            
            snapshot.appendSections([0])
            snapshot.appendItems(models)
            
            if #available(iOS 15.0, *) {
                self?.dataSource.applySnapshotUsingReloadData(snapshot, completion: { [weak self] in
                    self?.alreadyGetNews()
                })
            } else {
                self?.dataSource.apply(snapshot, animatingDifferences: animated, completion: { [weak self] in
                    self?.alreadyGetNews()
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let news = dataSource.itemIdentifier(for: indexPath) else { return }
        presenter.showDetailedInfoVC(view: self, news: news)
    }
}

// MARK: - UICollectionViewCompositionalLayout
extension EmailedNewsViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
}
