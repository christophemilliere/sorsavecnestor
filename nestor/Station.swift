//
//  Station.swift
//  nestor
//
//  Created by milliere on 26/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import MapKit

class Station: NSObject, MKAnnotation {
    
    var name: String?
    var subtitle: String?
    var coordinate : CLLocationCoordinate2D
    fileprivate var id: Int?
    fileprivate var category:String
    fileprivate var subCategory:String?
    fileprivate var picture:String
    
    
    init(title: String, coordinate: CLLocationCoordinate2D, id: Int, category: String, subCategory: String?, picture: String) {
        self.name = title
        self.coordinate = coordinate
        self.id = id
        self.category = category
        self.subCategory = subCategory
        self.picture = picture
    }
    
    var get_id:Int{
        get { return id! }
    }
    
    var get_name:String? {
        get { return name }
    }
    
    var get_category:String? {
        get { return category }
    }
    
    var get_subCategory:String? {
        get { return subCategory }
    }
    
    var get_picture:String? {
        get { return "http://\(picture)" }
    }
    
    func categoryOrSubCategory() -> String {
        if let catg_sub_catg:String = get_subCategory{
            return "\(get_category!) / \(catg_sub_catg)"
        } else {
            return get_category!
        }
    }
    
}
