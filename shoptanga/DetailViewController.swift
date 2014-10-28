//
//  DetailViewController.swift
//  shoptanga
//
//  Created by Chris Young on 10/26/14.
//  Copyright (c) 2014 Chris Young. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSubtitle: UITextView!
    @IBOutlet weak var msrp: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UIWebView!
    
    var detailItem: AnyObject?

    func configureView() {

        if self.detailItem == nil || self.productName == nil {return}
        let product = detailItem as Product
        productName.text = product.name
        productSubtitle.text = product.subtitle
        productImage.image = UIImage(data: product.image as NSData)
        product.description = product.styledDescription
        productDescription.loadHTMLString(product.description as String, baseURL: nil)
        price.text = NSString(format: "$%.2f", product.normalPrice)
        msrp.text = NSString(format: "$%.2f", product.msrp)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

