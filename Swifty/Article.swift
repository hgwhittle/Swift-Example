//
//  Article.swift
//  Swifty
//
//  Created by Hunter Whittle on 12/12/14.
//  Copyright (c) 2014 Hunter Whittle. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var name: NSString = "";
    var message: NSString = "";
    var imagePath: NSString = "";
    
    init(name: NSString, message: NSString, imagePath: NSString) {
        
        self.name = name;
        self.message = message;
        self.imagePath = imagePath;
    }
}
