
//  Schedule.swift
//  nestor
//
//  Created by milliere on 28/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    
    private var _date_start:String
    private var _time_start:String
    private var _time_end:String
    
    init( date_start:String, time_start:String, time_end:String){
        
        self._date_start = date_start
        self._time_start = time_start
        self._time_end = time_end
    }
    
    
    var date_start:String {
        get { return _date_start }
    }
    
    var time_start:String {
        get { return _time_start }
    }
    
    var time_end:String {
        get { return _time_end }
    }
    
    func get_month() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let ds = dateFormatter.date(from: date_start)
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: ds!)
        
    }
    
    func get_day() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let ds = dateFormatter.date(from: date_start)
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: ds!)
        
    }
    
    
    func get_year() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let ds = dateFormatter.date(from: date_start)
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: ds!);
    }
    
    
    func get_day_by_name() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date_start)
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date!);
    }
    
    
    func get_time_start() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let timeStart = dateFormatter.date(from: time_start)
        dateFormatter.dateFormat = nil
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: timeStart!);
    }
    
    func get_time_end() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let timeEnd = dateFormatter.date(from: time_end)
        dateFormatter.dateFormat = nil
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: timeEnd!);
    }
}
