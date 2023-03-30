//
//  NewsFeedService.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import Foundation
import XMLCoder
import XMLMapper

protocol NewsFeedServiceProtocol {
    func getNewsFeed(completion: @escaping (_ success: Bool, _ results: NewsFeed?, _ error: String?) -> ())
}

class NewsFeedService: NewsFeedServiceProtocol {
    func getNewsFeed(completion: @escaping (Bool, NewsFeed?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss") { success, data in
            if success {
                guard let data = data else {
                    fatalError("No data returned")
                }
                
                if let xmlString = String(data: data, encoding: .utf8),
                    let newsFeed = XMLMapper<NewsFeed>().map(XMLString: xmlString) {
                    
                    completion(true, newsFeed, nil)
                } else {
                    completion(false, nil, "Error: Trying to parse NewsFeed to model")
                }
            } else {
                completion(false, nil, "Error: NewsFeed GET Request failed")
            }
        }
    }
}
