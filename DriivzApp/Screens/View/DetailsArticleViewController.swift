//
//  DetailsArticleViewController.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 30/03/2023.
//

import UIKit
import Kingfisher

class DetailsArticleViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    var cellViewModel: NewsArticleCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = cellViewModel?.title
        descriptionLabel.text = cellViewModel?.description
        linkTextView.text = cellViewModel?.link
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
