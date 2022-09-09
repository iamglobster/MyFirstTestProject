//
//  ViewedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - ViewedNewsViewControllerProtocol
protocol ViewedNewsViewControllerProtocol {
    func update(with models: [Result], animated: Bool)
}

// MARK: - ViewedNewsViewController
class ViewedNewsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var viewedCollectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var dataSource = configureDataSource()
    private let presenter: ViewedNewsPresenterProtocol
    private let cellType: String = String(describing: NewsCell.self)
    
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
        setupUI()
        view.showActivityIndicator()
        presenter.getNews(period: 30)
    }
}

// MARK: - Private Extension
private extension ViewedNewsViewController {
    
    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Viewed news"
    }
    
    func setupCollectionView() {
        viewedCollectionView.delegate = self
        viewedCollectionView.dataSource = dataSource
        viewedCollectionView.register(.init(nibName: cellType, bundle: nil), forCellWithReuseIdentifier: cellType)
        
        viewedCollectionView.collectionViewLayout = createLayout()
        viewedCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func animateOpacity() {
        viewedCollectionView.layer.opacity = 0
        UIView.animate(withDuration: 0.5) {
            self.viewedCollectionView.layer.opacity = 1
        }
    }
    
    func alreadyGetNews() {
        animateOpacity()
        view.hideActivityIndicatorView()
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension ViewedNewsViewController {
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Int, Result> {
        let dataSource = UICollectionViewDiffableDataSource<Int, Result>(
            collectionView: viewedCollectionView) { collectionView, indexPath, model in
                (collectionView.dequeueReusableCell(withReuseIdentifier: self.cellType, for: indexPath) as? NewsCell)?.config(with: model)
            }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension ViewedNewsViewController: ViewedNewsViewControllerProtocol, UICollectionViewDelegate {
    
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

// MARK: - UICollectionViewLayout
extension ViewedNewsViewController {
    
    private func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)

        return layout
    }
}
