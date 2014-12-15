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
    
    class func getArticles(success: (responseArray: NSArray!)->(), failure: (error: NSError!)->()) {
        
        Alamofire.request(.GET, "https://hgwhittle.com/stuff.php", parameters: nil, encoding: .JSON)
        .responseJSON { (request, response, JSON, error) -> Void in
            
            if error != nil {
                failure(error: error)
            }
            else {
                
                println(JSON)
                
                let responseDict: NSDictionary = JSON as NSDictionary
                let responseArray: NSArray = responseDict.valueForKey("articles") as NSArray
                
                let articleArray: NSMutableArray = NSMutableArray()
                for var i=0; i<responseArray.count; i++ {
                    
                    let dict: NSDictionary = responseArray.objectAtIndex(i) as NSDictionary
                    
                    let name: NSString = dict.valueForKey("name") as NSString
                    let message: NSString = dict.valueForKey("message") as NSString
                    
                    let article: Article = Article(name: name, message: message)
                    articleArray.addObject(article)
                }
                
                success(responseArray: articleArray)
            }
        }
    }
}
