//
//  SchedulesViewController.swift
//  nestor
//
//  Created by milliere on 29/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SchedulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    var event_id:Int!
    var schedulesItem: Schedule?
    var schedulesList = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        
        Alamofire.request("http://sorsavecnestor.com/api/v1/events/times/\(self.event_id!)", method: .get)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    print(value)
                    for index in 0 ..< json["events"].count {
                        if  !json["events"][index]["time_end"].stringValue.isEmpty && !json["events"][index]["time_end"].stringValue.isEmpty {
                            let sch = Schedule(date_start: json["events"][index]["date_start"].stringValue, time_start: json["events"][index]["time_start"].stringValue, time_end: json["events"][index]["time_end"].stringValue)
                            
                            self.schedulesList.append(sch)
                        }
                        
                    } // end for
                    
                    self.tableview.reloadData()
                }
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedulesList.count
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSchedule") as! SchedulesTableViewCell
        cell.day.text = schedulesList[(indexPath as NSIndexPath).row].get_day_by_name()
        cell.number.text = schedulesList[(indexPath as NSIndexPath).row].get_day()
        cell.month.text = schedulesList[(indexPath as NSIndexPath).row].get_month()
        cell.times.text = "\(schedulesList[(indexPath as NSIndexPath).row].get_time_start()) à \(schedulesList[(indexPath as NSIndexPath).row].get_time_end())"
        return cell
    }

}
