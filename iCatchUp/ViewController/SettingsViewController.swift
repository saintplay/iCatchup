//
//  SettingsViewController.swift
//  iCatchUp
//
//  Created by Diego Jara on 6/3/18.
//  Copyright © 2018 acme. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testConnectivity()
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func testConnectivity() {
        let parameters = ["apiKey": NewsApi.key, "country": "us"]
        Alamofire.request(NewsApi.topHeadlinesUrl, parameters: parameters)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let status = json["status"].stringValue
                    if status == "ok" {
                        let articles = Article.buildAll(from: json["articles"].arrayValue)
                        print("Found \(articles.count) Articles")
                    }
                case .failure(let error):
                    print("Networking Error: \(error.localizedDescription)")
                }
            })
    }

}
