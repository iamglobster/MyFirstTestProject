//
//  FavouriteNewsViewController.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 04.09.2022.
//

import UIKit
import CoreData

// MARK: - FavoritesNewsViewControllerProtocol
protocol FavoritesNewsViewControllerProtocol {
    func update(with models: [Result], animated: Bool)
}

// MARK: - FavoritesNewsViewController
class FavoritesNewsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var dataSource = configureDataSource()
    private var presenter: FavoritesNewsPresenterProtocol
    private var cellType: String = String(describing: FavoritesNewsCell.self)
    
    // MARK: - Init
    init(presenter: FavoritesNewsPresenterProtocol) {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchItem()
    }
}

// MARK: - Private Extension
private extension FavoritesNewsViewController {
    
    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Your favorites news"
    }
    
    func setupCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = dataSource
        favoritesCollectionView.register(.init(nibName: cellType, bundle: nil), forCellWithReuseIdentifier: cellType)
        
        favoritesCollectionView.collectionViewLayout = createLayout()
        favoritesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func animateOpacity() {
        favoritesCollectionView.layer.opacity = 0
        UIView.animate(withDuration: 0.5) {
            self.favoritesCollectionView.layer.opacity = 1
        }
    }
    
    func alreadyGetNews() {
        animateOpacity()
        view.hideActivityIndicatorView()
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension FavoritesNewsViewController {
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Int, Result> {
        let dataSource = UICollectionViewDiffableDataSource<Int, Result>(
            collectionView: favoritesCollectionView) { collectionView, indexPath, model in
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: self.cellType, for: indexPath) as! FavoritesNewsCell).config(with: model)
                cell.completion = { [weak self] in
                    self?.presenter.deleteItem(id: model.uuid ?? UUID(), index: indexPath.row)
                    self?.view.showActivityIndicator()
                }
                return cell
            }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesNewsViewController: FavoritesNewsViewControllerProtocol, UICollectionViewDelegate {

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
}

// MARK: - UICollectionViewLayout
extension FavoritesNewsViewController {
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: presenter.news.count == 1 ? .fractionalWidth(1.0) : .absolute(UIScreen.main.bounds.width - 28),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        
        return layout
    }
}
