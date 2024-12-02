//
//  EventCell.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 8/11/24.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var img_eventImage: UIImageView!
    @IBOutlet weak var lbl_eventTitle: UILabel!
    @IBOutlet weak var lbl_eventHour: UILabel!
    @IBOutlet weak var lbl_eventDate: UILabel!
    @IBOutlet weak var lbl_eventPlace: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
