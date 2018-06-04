//
//  Source.swift
//  iCatchUp
//
//  Created by Diego Jara on 6/1/18.
//  Copyright © 2018 acme. All rights reserved.
//

import Foundation
import SwiftyJSON

class Source {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
    
    init (
        id: String,
        name: String,
        description: String,
        url: String,
        category: String,
        language: String,
        country: String
        ) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
    
    convenience init(id: String, name: String) {
        self.init(id: id, name: name, description: "", url: "", category: "", language: "", country: "")
    }
    
    convenience init(jsonSource: JSON) {
        self.init(
            id: jsonSource["id"].stringValue,
            name: jsonSource["name"].stringValue,
            description: jsonSource["description"].stringValue,
            url: jsonSource["url"].stringValue,
            category: jsonSource["category"].stringValue,
            language: jsonSource["language"].stringValue,
            country: jsonSource["country"].stringValue
        )
    }
    
    public var urlToLogo: String {
        return LogoApi.urlToLogo(forString: url)
    }
}
