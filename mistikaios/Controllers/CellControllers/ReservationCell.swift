//
//  ReservationCell.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit

class ReservationCell: UITableViewCell {

    @IBOutlet weak var lbl_reservationDate: UILabel!
    @IBOutlet weak var lbl_reservationState: UILabel!
    @IBOutlet weak var lbl_reservationAmount: UILabel!
    @IBOutlet weak var lbl_reservationPayments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
