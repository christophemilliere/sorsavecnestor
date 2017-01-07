//
//  DetailEventViewController.swift
//  nestor
//
//  Created by milliere on 24/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController, UIScrollViewDelegate {
    
    var detailItem: Event!
    
    @IBOutlet var scrollViewEvent: UIScrollView!
    @IBOutlet var categoryAndSubCategory: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var durationEvent: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var eventDescription: UITextView!
    @IBOutlet var price: UIBarButtonItem!
    
    var counts: Int!
    
    @IBAction func viewPrices(_ sender: AnyObject) {
        
        var text = ""
        for index in 0 ..< counts {
            if detailItem?.priceReduced[index]["reduced_price"] != 0 {
                text += "\(detailItem!.priceReduced[index]["information"]) : \(detailItem!.priceReduced[index]["reduced_price"]) \n"
            }
        }
        let alertController = UIAlertController(title: "Tarif", message: text, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollViewEvent.delegate = self
        self.counts = detailItem?.priceReduced.count
        
        self.name.text = self.detailItem.name
        self.durationEvent.text = self.detailItem.event_duration()
        self.categoryAndSubCategory.text = self.detailItem.allCategory(category: self.detailItem.category, subCategory: self.detailItem.subCategory)
        self.picture!.image = UIImage(data: (NSData(contentsOf: (NSURL(string:"http://\(self.detailItem.picture)"))! as URL))! as Data)
        self.eventDescription.text = self.detailItem.desc
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let eventHeight = eventDescription.frame.size.height;
        scrollView.contentOffset.x = 0
        scrollView.contentSize.height = eventHeight + 320
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "schedule_id" {
            (segue.destination as! SchedulesViewController).event_id = detailItem.id
            
        }
    }

}
