//
//  SchedulesTableViewCell.swift
//  nestor
//
//  Created by milliere on 28/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class SchedulesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scheduleBgView: UIView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var times: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scheduleBgView.layer.cornerRadius = 5;
        self.scheduleBgView.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
