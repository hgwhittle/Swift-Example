//
//  ViewController.swift
//  Swifty
//
//  Created by Hunter Whittle on 12/11/14.
//  Copyright (c) 2014 Hunter Whittle. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellID = "CellID"
    
    var sourceArray: NSArray = NSArray()
    var dummyCell: ArticleCell = ArticleCell()
    
    @IBOutlet weak var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.theTableView.dataSource = self;
        self.theTableView.delegate = self;
        self.theTableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        self.dummyCell = NSBundle.mainBundle().loadNibNamed("ArticleCell", owner: self, options: nil)[0] as ArticleCell
        
        self.showActivity()
        APIHelper.getArticles({ (responseArray) -> () in
            
            self.hideActivity()
            self.sourceArray = responseArray
            self.theTableView.reloadData()
            
        }, failure: { (error) -> () in
            self.hideActivity()
            println(error)
        })
    }
    
    //MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: ArticleCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as ArticleCell
        
        let article: Article = self.sourceArray.objectAtIndex(indexPath.row) as Article
        
        cell.nameLabel!.text = article.name
        cell.messageLabel!.text = article.message
        
        APIHelper.getImage(article.imagePath, success: { (theImage) -> () in
            
            cell.theImageView.image = theImage
            
        }) { (error) -> () in
            
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let inset = UIEdgeInsetsMake(0, 12, 0, 0)
        
        if tableView.respondsToSelector(Selector("setSeparatorInset:")) {
            tableView.separatorInset = inset
        }
        
        if tableView.respondsToSelector(Selector("setLayoutMargins:")) {
            tableView.layoutMargins = inset
        }
        
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = inset
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let article: Article = self.sourceArray.objectAtIndex(indexPath.row) as Article
        let text = article.message
        let width = self.dummyCell.messageLabel.frame.size.width
        let font = self.dummyCell.messageLabel.font
        
        let string: NSAttributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
        
        let rect = string.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        
        let size = rect.size
        let labelY: CGFloat = self.dummyCell.messageLabel.frame.origin.y
        let padding: CGFloat = 5.0
        let height = CGFloat(ceilf(Float(size.height))) + labelY + padding
        return height
    }
    
    //MARK: Private methods
    
    private func showActivity() {
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activity.frame = CGRectMake(0, 0, 75, 75)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        self.navigationItem.titleView = activity
    }
    
    private func hideActivity() {
        
        self.navigationItem.titleView = nil;
        self.title = "Article Feed"
    }
}

