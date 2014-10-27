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
    @IBOutlet weak var productSubtitle: UILabel!
    @IBOutlet weak var msrp: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    
    
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let detail: AnyObject = self.detailItem {
            if let label = self.productName {
                let product = detailItem as Product
                productName.text = product.name
//                productSubtitle.text = product.subtitle
//                productDescription.text = product.description
//                price.text = NSString(format: "$%.2f", product.normalPrice)
//                msrp.text = NSString(format: "$%.2f", product.msrp)
//                productImage.image = UIImage(data: product.image as NSData)
            }
        }
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

