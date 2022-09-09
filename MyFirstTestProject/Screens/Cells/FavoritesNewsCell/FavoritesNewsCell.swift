//
//  FavoritesNewsCell.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 07.09.2022.
//

import UIKit
import Kingfisher

// MARK: - FavoritesNewsCell
class FavoritesNewsCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var deleteNewsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    var completion: EmptyClosure?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func config(with model: Result) -> FavoritesNewsCell {
        guard let url = model.url else {
            return self
        }
        newsImageView.kf.setImage(with: url)
        titleLabel.text = model.title
        
        return self
    }
}

// MARK: - Private Extension
private extension FavoritesNewsCell {
    func setupUI() {
        setupImageView()
    }
    
    func setupImageView() {
        newsImageView.layer.cornerRadius = 15
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(deleteAction))
        deleteNewsImageView.addGestureRecognizer(gesture)
        deleteNewsImageView.isUserInteractionEnabled = true
        deleteNewsImageView.clipsToBounds = true
    }
    
    @objc
    func deleteAction() {
        completion?()
    }
}
