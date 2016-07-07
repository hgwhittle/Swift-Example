//
//  APIHelper.swift
//  Swifty
//
//  Created by Hunter Whittle on 12/12/14.
//  Copyright (c) 2014 Hunter Whittle. All rights reserved.
//

import UIKit
import Alamofire

class APIHelper: NSObject {
    
    class func getArticles(success: (responseArray: [Article])->(), failure: (error: NSError)->()) {
        Alamofire.request(.GET, "https://box975.bluehost.com:2083/stuff.php", parameters: nil, encoding: .JSON)
        .responseJSON { response in
            switch response.result {
            case .Success(let JSON):
                print(JSON)
                let responseDict = JSON as! NSDictionary
                
                let responseArray = responseDict["articles"] as! [[String: AnyObject]]
                var articleArray = [Article]()
                for dict in responseArray {
                    let name = dict["name"] as! String
                    let message = dict["message"] as! String
                    let imagePath = dict["imagePath"] as! String
                    let article = Article(name: name, message: message, imagePath: imagePath)
                    articleArray.append(article)
                }

                success(responseArray: articleArray)
                break
            case .Failure(let error):
                failure(error: error)
                break
            }
        }
    }
    
    class func getImage(path: String, success: (theImage: UIImage!)->(), failure: (error: NSError!)->()) {
        Alamofire.request(.GET, NSURL(string: path)!)
        .response() { (_, _, data, error) in
            if error != nil {
                failure(error: error)
            }
            else {
                let image = UIImage(data: data! as NSData)
                success(theImage: image)
            }
        }
    }
}
