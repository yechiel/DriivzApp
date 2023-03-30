//
//  NewsArticle.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import Foundation
import XMLMapper

// MARK: - NewsArticle
class NewsArticle: XMLMappable {
    var nodeName: String!
    var title: String?
    var link: String?
    var description: String?
    var imageUrl: Media?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        title <- map["title"]
        link <- map["link"]
        description <- map["description"]
        imageUrl <- map["enclosure"]
    }
}

class Media: XMLMappable {
    var nodeName: String!
    var url: String?
    
    required init?(map: XMLMap) {}
    
    func mapping(map: XMLMap) {
        url <- map.attributes["url"]
    }
}
