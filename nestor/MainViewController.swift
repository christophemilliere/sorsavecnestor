//
//  ViewController.swift
//  nestor
//
//  Created by milliere on 22/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var filter: UIBarButtonItem!
    var eventsLists = [Event]()
    let location = Location()
    var searchParams = [String:AnyObject]()
    var params = [String:AnyObject]()
    var url = String()
    var refreshControl: UIRefreshControl!
    
    @IBOutlet var list: UITabBarItem!
    
    
    @IBAction func filterTarget(_ sender: AnyObject) {
        
//        self.performSegue(withIdentifier: "filter", sender: sender)
        let vc : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController;
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        location.findUserLocation()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.navigationItem.title = "Nestor"
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor.init(hex: 0xAF1976)
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //date current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: currentDate)
        
        url = "http://vps124843.ovh.net/api/v1/events"
        params = ["date": convertDate as AnyObject]
        
        
        if searchParams.count != 0 {
            url = "http://vps124843.ovh.net/api/v1/events/search"
            self.params = self.searchParams
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(MainViewController.refreshTable(refreshControl:)), for: UIControlEvents.valueChanged)
        self.tableview.addSubview(refreshControl)
        
        addInformationTableview(params, url: url)
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableView method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsLists.count
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "EventCell"
        let indexEvent = self.eventsLists[indexPath.row]
        
        let latitude = indexEvent.location["latitude"]?.doubleValue
        let longitude = indexEvent.location["longitude"]?.doubleValue
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: identifier) as? EventsTableViewCell)!
        
//        if location.distance( latitude!, long: longitude!).characters.count >= 9 {
//            location.findUserLocation()
//            self.tableview.reloadData()
//        }
        
        cell.selectionStyle = .none

        cell.name.text = indexEvent.name
        cell.picture!.image = UIImage(data: (NSData(contentsOf: (NSURL(string:"http://\(indexEvent.picture)"))! as URL))! as Data)
        cell.fullCategoryAndSubCategory.text = indexEvent.allCategory(category: indexEvent.category, subCategory: indexEvent.subCategory)
        cell.meter.text = location.distance( latitude!, long: longitude!)
        
        return cell
    }
    
    // action tableview
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEvent" {
 
            if let IndexPath = self.tableview.indexPathForSelectedRow{
                let object = eventsLists[IndexPath.row]
                (segue.destination as! DetailEventViewController).detailItem = object
            }
            
        }
        
        if segue.identifier == "filter" {
        }
    }
    
    func refreshTable(refreshControl: UIRefreshControl) {
        
        //date current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: currentDate)
        
        params = ["date": convertDate as AnyObject]
        
        url = "http://vps124843.ovh.net/api/v1/events"
        
        addInformationTableview(params, url: url)
        refreshControl.endRefreshing()
    }
    
    func addInformationTableview(_ params: [String:AnyObject], url: String){
        self.eventsLists.removeAll()
        self.view.activityIndicatorView.startAnimating()
        Alamofire.request(url, method: .get, parameters: params )
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    for index in 0 ..< json["events"].count {
                        
                        let ev = Event(name: json["events"][index]["name"].stringValue, keywords: json["events"][index]["keywords"].stringValue, desc: json["events"][index]["description"].stringValue, humor: json["events"][index]["humor_name"].stringValue, words_organizer: json["events"][index]["words_organizer"].stringValue, picture: json["events"][index]["picture"].stringValue, price: json["events"][index]["price"].intValue, location: json["events"][index]["location"].dictionaryValue, priceReduced: json["events"][index]["reduced_price"].arrayValue, category:json["events"][index]["category_name"].stringValue, subCategory: json["events"][index]["sub_category_name"].stringValue, id: json["events"][index]["id"].intValue, date_start: json["events"][index]["date_start"].stringValue, date_end: json["events"][index]["date_end"].stringValue, next_date: json["events"][index]["next_date"].dictionaryValue)
                        
                        self.eventsLists.append(ev)
                        
                    } // end for
                    
                    self.view.activityIndicatorView.stopAnimating()
                    self.tableview.reloadData()
                }
        }
        
    }
    

}

