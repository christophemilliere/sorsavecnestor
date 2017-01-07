//
//  MapsController.swift
//  nestor
//
//  Created by milliere on 25/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapsController: UIViewController, MKMapViewDelegate {
    @IBOutlet var maps: MKMapView!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var category_subCategory: UILabel!
    @IBOutlet var mapViewDetail: UIView!
    
    var eventsLists = [Event]()
    let tapRec = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Carte"
        self.navigationItem.hidesBackButton = true
        self.maps.delegate = self
        self.all_events()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //maps
    func zoomToRegion() {
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.1 , 0.1)
        let location:CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude:48.8653202, longitude:  2.4401392)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        maps.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.mapViewDetail.isHidden = false
        if let pinAnnotation = view.annotation as? Station{
            self.picture.image = UIImage(data: try! Data(contentsOf: URL(string:pinAnnotation.get_picture!)!))
            self.labelTitle.text = pinAnnotation.get_name
            self.category_subCategory.text = pinAnnotation.categoryOrSubCategory()
            let gestureRecognizer = MyTapGestureRecognizer(target: self, action: #selector(tapped))
            gestureRecognizer.index = pinAnnotation.get_id
            mapViewDetail.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    
    func tapped(_ gestureRecognizer: MyTapGestureRecognizer) {
        if let index = gestureRecognizer.index {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let item = storyboard.instantiateViewController(withIdentifier: "DetailEventViewController") as! DetailEventViewController
            item.detailItem = eventsLists[index]
            self.navigationController?.show(item, sender: self)
        }
    }
    
    func getMapAnnotations() {
        for item in 0 ..< self.eventsLists.count {
            
            let long = self.eventsLists[item].location["longitude"]!.doubleValue
            let lat = self.eventsLists[item].location["latitude"]!.doubleValue
            let id = item
            let category = self.eventsLists[item].category
            let subCategory = self.eventsLists[item].subCategory
            let image_url = self.eventsLists[item].picture
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let anotation = Station(title: self.eventsLists[item].name, coordinate: location, id: id, category: category, subCategory: subCategory, picture: image_url)
            self.maps.addAnnotation(anotation);
            
        }
    }
    
    //alamofire
    
    func all_events(){
        Alamofire.request("http://vps124843.ovh.net/api/v1/events", method: .get, encoding: JSONEncoding.default )
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    for index in 0 ..< json["events"].count {
                        
                        let ev = Event(name: json["events"][index]["name"].stringValue, keywords: json["events"][index]["keywords"].stringValue, desc: json["events"][index]["description"].stringValue, humor: json["events"][index]["humor_name"].stringValue, words_organizer: json["events"][index]["words_organizer"].stringValue, picture: json["events"][index]["picture"].stringValue, price: json["events"][index]["price"].intValue, location: json["events"][index]["location"].dictionaryValue, priceReduced: json["events"][index]["reduced_price"].arrayValue, category:json["events"][index]["category_name"].stringValue, subCategory: json["events"][index]["sub_category_name"].stringValue, id: json["events"][index]["id"].intValue, date_start: json["events"][index]["date_start"].stringValue, date_end: json["events"][index]["date_end"].stringValue, next_date: json["events"][index]["next_date"].dictionaryValue)
                        self.eventsLists.append(ev)
                        
                    } // end for
                    self.zoomToRegion()
                    self.getMapAnnotations()
                }
        }
    } //end func
}
