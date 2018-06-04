//
//  HomeViewController.swift
//  iCatchUp
//
//  Created by Diego Jara on 6/1/18.
//  Copyright © 2018 acme. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

private let reuseIdentifier = "Cell"

class HeadlineCell: UICollectionViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func updateViews(from article: Article) {
        titleLabel.text = article.title
        if let url = URL(string: article.urlToImage) {
            pictureImageView.af_setImage(withURL: url)
        }
    }
}

class HomeViewController: UICollectionViewController {
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        updateData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeadlineCell
    
        // Configure the cell
        cell.updateViews(from: articles[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    func updateData() {
        let parameters = ["apiKey": NewsApi.key, "country": "us"]
        Alamofire.request(NewsApi.topHeadlinesUrl, parameters: parameters)
        .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].stringValue
                    if status == "error" {
                        print("NewsApi Error: \(json["message"].stringValue)")
                        return
                    }
                    self.articles = Article.buildAll(from:
                        json["articles"].arrayValue)
                    self.collectionView!.reloadData()
                    
                case .failure(let error):
                    print("Response Error: \(error.localizedDescription)")
                }
            })
    }
}
