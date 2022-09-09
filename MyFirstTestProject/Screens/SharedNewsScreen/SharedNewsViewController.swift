//
//  SharedNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit

// MARK: - SharedNewsViewControllerProtocol
protocol SharedNewsViewControllerProtocol {
    func update(with models: [Result], animated: Bool)
}

// MARK: - SharedNewsViewController
class SharedNewsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var sharedCollectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var dataSource = configureDataSource()
    private let presenter: SharedNewsPresenterProtocol
    private var cellType: String = String(describing: NewsCell.self)
    
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
        setupUI()
        view.showActivityIndicator()
        presenter.getNews(period: 30)
    }
}

// MARK: - Private Extension
private extension SharedNewsViewController {
    
    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Shared news"
    }
    
    func setupCollectionView() {
        sharedCollectionView.delegate = self
        sharedCollectionView.dataSource = dataSource
        sharedCollectionView.register(.init(nibName: cellType, bundle: nil), forCellWithReuseIdentifier: cellType)
        
        sharedCollectionView.collectionViewLayout = createLayout()
        sharedCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func animateOpacity() {
        sharedCollectionView.layer.opacity = 0
        UIView.animate(withDuration: 0.5) {
            self.sharedCollectionView.layer.opacity = 1
        }
    }
    
    func alreadyGetNews() {
        animateOpacity()
        view.hideActivityIndicatorView()
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension SharedNewsViewController {
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Int, Result> {
        let dataSource = UICollectionViewDiffableDataSource<Int, Result>(
            collectionView: sharedCollectionView) { collectionView, indexPath, model in
                (collectionView.dequeueReusableCell(withReuseIdentifier: self.cellType, for: indexPath) as? NewsCell)?.config(with: model)
            }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension SharedNewsViewController: SharedNewsViewControllerProtocol, UICollectionViewDelegate {
    
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
extension SharedNewsViewController {
    
    private func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)

        return layout
    }
}
