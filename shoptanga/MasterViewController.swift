//
//  MasterViewController.swift
//  shoptanga
//
//  Created by Chris Young on 10/26/14.
//  Copyright (c) 2014 Chris Young. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet var appsTableView : UITableView?
    var tableData = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        getIndex()
    }

    func getIndex() {
        let url: NSURL = NSURL(string: "http://www.tanga.com/deals/front-page.json")!
        
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            if(error != nil) { println(error.localizedDescription) }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableData = self.parse(data)
                self.appsTableView!.reloadData()
            })
            
        }).resume()
    }
    
    func parse(data: NSData) -> NSArray {
        return JSON(data: data).object as NSArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = tableData[indexPath.row] as NSDictionary
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel.text = rowData["name"] as? String
        cell.imageView.image = UIImage(data: imageFromRow(rowData))
        
        return cell
    }
    
    func imageFromRow(rowData: NSDictionary) -> NSData{
        let images = rowData["images"] as NSArray
        let image = images[0] as NSDictionary
        let urlString = image["url"] as NSString
        let imgURL: NSURL = NSURL(string: urlString)!
        return NSData(contentsOfURL: imgURL)!
    }
}

