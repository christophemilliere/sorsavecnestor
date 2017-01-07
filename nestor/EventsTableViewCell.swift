//
//  eventsTableViewCell.swift
//  nestor
//
//  Created by milliere on 24/09/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var picture: UIImageView?
    @IBOutlet var fullCategoryAndSubCategory: UILabel!
    @IBOutlet var meter: UILabel!
    @IBOutlet var eventDescription: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.meter.layer.cornerRadius = 10.0
        self.meter.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
