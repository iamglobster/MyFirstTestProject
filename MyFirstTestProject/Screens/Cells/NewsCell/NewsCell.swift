//
//  NewsCell.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

import UIKit
import Kingfisher

// MARK: - NewsCell
class NewsCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Methods
    func config(with model: Result) -> NewsCell {
        model.media?.forEach { media in
            media.mediametadata?.forEach {
                guard let image = $0.url, let url = URL(string: image) else { return }
                DispatchQueue.main.async {
                    self.newsImageView.kf.setImage(with: url)
                }
            }
        }
        titleLabel.text = model.title
        return self
    }
}

// MARK: - Private Extension
private extension NewsCell {
    func setupUI() {
        newsImageView.layer.cornerRadius = 5
    }
}
