//
//  LogoApi.swift
//  iCatchUp
//
//  Created by Diego Jara on 6/1/18.
//  Copyright © 2018 acme. All rights reserved.
//

import Foundation

class LogoApi {
    static let baseUrl = "https://logo.clearbit.com/"
    
    public static func urlToLogo(forString string: String,
                                 withSize size: Int = 128) -> String {
        if let url = URL(string: string) {
            return "\(baseUrl)\(url.host!)?size=\(size)"
        }
        return "\(baseUrl)\(string)?size=\(size)"
    }
}
