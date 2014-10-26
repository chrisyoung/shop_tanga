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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getIndex()
    }

    func getIndex() {
        let url: NSURL = NSURL(string: "http://www.tanga.com/deals/front-page.json")!
        
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            if(error != nil) { println(error.localizedDescription) }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableData = Product.buildFromJSON(data)
                self.appsTableView!.reloadData()
            })
            
        }).resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = tableData[indexPath.row] as Product
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let product: Product = self.tableData[indexPath.row] as Product
        
        cell.textLabel.text = product.name
        cell.imageView.image = UIImage(data: product.images[0] as NSData)
        
        
        return cell
    }
    
    func imageFromRow(rowData: NSDictionary) -> NSData{
        let image = (rowData["images"] as NSArray)[0] as NSDictionary
        let imgURL: NSURL = NSURL(string: image["url"] as NSString)!
        return NSData(contentsOfURL: imgURL)!
    }
}

