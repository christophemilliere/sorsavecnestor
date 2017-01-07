//
//  Event.swift
//  nestor
//
//  Created by milliere on 23/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import SwiftyJSON
class Event: NSObject {
    
    private var _id:Int
    private var _name:String
    private var _keywords:String
    private var _desc:String
    private var _humor:String
    private var _words_organizer:String
    private var _picture:String
    private var _price:Int
    private var _location:[String:JSON]
    private var _priceReduced:[JSON]
    private var _category:String
    private var _subCategory:String?
    private var _date_start: String
    private var _date_end: String
    private var _next_date:[String:JSON]
    
    init(name:String, keywords:String, desc:String, humor:String, words_organizer:String, picture:String, price:Int, location:[String:JSON], priceReduced:[JSON], category:String, subCategory:String, id:Int, date_start:String, date_end:String, next_date:[String:JSON]) {
        self._name = name
        self._keywords = keywords
        self._desc = desc
        self._humor = humor
        self._words_organizer = words_organizer
        self._picture = picture
        self._price = price
        self._location = location
        self._priceReduced = priceReduced
        self._category = category
        self._subCategory = subCategory
        self._id = id
        self._date_start = date_start
        self._date_end = date_end
        self._next_date = next_date
        
    }
    
    var id:Int{
        get { return _id}
    }
    
    var name:String{
        get { return _name}
    }
    
    var keywords:String{
        get { return _keywords }
    }
    
    var desc:String{
        get { return _desc }
    }
    
    var humor:String{
        get { return _humor }
    }
    
    var words_organizer:String{
        get { return _words_organizer }
    }
    
    var picture:String{
        get { return _picture }
    }
    
    var price:Int{
        get { return _price }
    }
    
    var category:String {
        get { return _category }
    }
    
    var subCategory:String {
        get { return _subCategory! }
    }
    
    var location:[String:JSON]{
        get { return _location }
    }
    
    var priceReduced:[JSON]{
        get { return _priceReduced }
    }
    
    func allCategory(category:String, subCategory:String) -> String {
        if let catg_sub_catg:String = subCategory{
            return "\(category) / \(catg_sub_catg)"
        } else {
            return category
        }
        
    }
    
    func event_duration() -> String{
        
        // date start
        let dateFormatter_start = DateFormatter()
        dateFormatter_start.dateFormat = "yyyy-MM-dd"
        let date_start = dateFormatter_start.date(from: _date_start)
        dateFormatter_start.dateFormat = "dd MMM"
        dateFormatter_start.string(from: date_start!)
        
        
        // date end
        let dateFormatter_end = DateFormatter()
        dateFormatter_end.dateFormat = "yyyy-MM-dd"
        let date_end = dateFormatter_end.date(from: _date_end)
        dateFormatter_end.dateFormat = "dd MMM"
        
        return "du \( dateFormatter_start.string(from: date_start!)) au \(dateFormatter_end.string(from: date_end!))"
    }
    
    func nex_date_time(){
        print(_next_date["date_start"]!)
        print(_next_date["times"]![0]["time_start"])
        
//        let d = "\(_next_date["date_start"]!) \(_next_date["times"]![0]["time_start"])"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM"
//        let dt = dateFormatter.date(from: d)
//        dateFormatter.dateFormat = "dd MMM"
//        dateFormatter.string(from: dt!)
    }
    
    
}
