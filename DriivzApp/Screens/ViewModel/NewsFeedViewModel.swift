//
//  NewsFeedViewModel.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import Foundation

class NewsFeedViewModel: NSObject {
    private var newsFeedService: NewsFeedServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var newsFeed: NewsFeed?
    var title: String?

    var newsArticleCellViewModels = [NewsArticleCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(newsFeedService: NewsFeedServiceProtocol = NewsFeedService()) {
        self.newsFeedService = newsFeedService
    }
    
    func getNewsFeed() {
        newsFeedService.getNewsFeed { success, model, error in
            if success, let newsFeed = model {
                self.fetchData(newsFeed: newsFeed)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(newsFeed: NewsFeed) {
        self.newsFeed = newsFeed
        self.title = newsFeed.title
        var vms = [NewsArticleCellViewModel]()
        for article in newsFeed.articles ?? [] {
            vms.append(createCellModel(article: article))
        }
        newsArticleCellViewModels = vms
    }
    
    func createCellModel(article: NewsArticle) -> NewsArticleCellViewModel {
        let title = article.title
        let description = article.description
        let imageUrl = article.imageUrl?.url
        let link = article.link
        
        return NewsArticleCellViewModel(title: title ?? "", description: description ?? "", imageUrl: imageUrl ?? "", link: link ?? "")
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> NewsArticleCellViewModel {
        return newsArticleCellViewModels[indexPath.row]
    }
}
