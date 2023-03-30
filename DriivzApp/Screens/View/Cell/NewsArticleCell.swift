//
//  NewsArticleCell.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import UIKit
import Kingfisher

class NewsArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: NewsArticleCellViewModel? {
        didSet {
            titleLabel.text = cellViewModel?.title
            descriptionLabel.text = cellViewModel?.description
            if let imageUrl = URL(string: cellViewModel?.imageUrl ?? "") {
                                
                articleImageView.kf.indicatorType = .activity
                articleImageView.kf.setImage(
                    with: imageUrl,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        articleImageView.image = nil
    }
}
