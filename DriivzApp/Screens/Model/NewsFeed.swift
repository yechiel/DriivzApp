//
//  NewsFeed.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import Foundation
import XMLMapper

// MARK: - NewsFeed
class NewsFeed: XMLMappable {
    var nodeName: String!
    var title: String?
    var articles: [NewsArticle]?

    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        title <- map["channel.title"]
        articles <- map["channel.item"]
    }
}
