//
//  NegocioCell.swift
//  mistikaios
//
//  Created by Deivid Jhon Del Carpio Vilca on 18/11/24.
//

import UIKit

class NegocioCell: UITableViewCell {

    @IBOutlet weak var lbl_negocioTitle: UILabel!
    @IBOutlet weak var img_negocioImage: UIImageView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
