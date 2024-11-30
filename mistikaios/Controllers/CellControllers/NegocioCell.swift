//
//  NegocioCell.swift
//  mistikaios
//
//  Created by Deivid Jhon Del Carpio Vilca on 18/11/24.
//

import UIKit

class NegocioCell: UITableViewCell {

    @IBOutlet weak var lbl_negocioTitle: UILabel!
    @IBOutlet weak var img_negocioImage: UIImageView!  // Cambiar de WKWebView a UIImageView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configurar la imagen
        img_negocioImage.contentMode = .scaleAspectFill  // Esto ayudará a mantener la proporción de la imagen
        img_negocioImage.layer.cornerRadius = 15
        img_negocioImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
