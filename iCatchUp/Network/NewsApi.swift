//
//  NewsApi.swift
//  iCatchUp
//
//  Created by Diego Jara on 6/1/18.
//  Copyright © 2018 acme. All rights reserved.
//

import Foundation

class NewsApi {
    static let baseUrl = "https://newsapi.org"
    
    public static var topHeadlinesUrl: String {
        return "\(baseUrl)/v2/top-headlines"
    }
    
    public static var everythingUrl: String {
        return "\(baseUrl)/v2/everyThing"
    }
    
    public static var sourcesUrl: String {
        return "\(baseUrl)/v2/sources"
    }
    
    public static var key: String {
        return Bundle.main.object(
        forInfoDictionaryKey: "NewsApiKey") as! String
    }
}
