//
//  TurismoDetallesViewController.swift
//  mistikaios
//
//  Created by David Quispe Maqque on 31/10/24.
//

import UIKit

class TurismoDetallesViewController: UIViewController {

    // Conectar el UIScrollView desde el storyboard
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Crear el contentView dentro del scrollView para contener los elementos
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Configurar restricciones para el contentView dentro del scrollView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Agregar una UILabel para mostrar el texto extenso
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Permite que el texto sea multilinea
        label.text = """
        Historia y Fundación:
        Yanahuara es un distrito con una rica historia que se remonta a la época colonial. Fue fundado en el siglo XVI, poco después de la fundación de Arequipa en 1540. El mirador fue construido posteriormente, y se ha convertido en un sitio de interés turístico por sus espectaculares vistas de la ciudad y del volcán Misti.

        Características del Mirador:
        Arcos de Sillar: El mirador está compuesto por una serie de arcos construidos en sillar, una piedra volcánica blanca típica de la región. Estos arcos están decorados con inscripciones de citas de personajes célebres de Arequipa.

        Vistas Panorámicas: Desde el mirador, se puede disfrutar de una vista panorámica de la ciudad de Arequipa, incluyendo su centro histórico y el imponente volcán Misti. En días despejados, también se pueden ver los volcanes Chachani y Pichu Pichu.

        Ambiente: La plaza donde se ubica el mirador es tranquila y está rodeada de jardines bien cuidados, lo que la convierte en un lugar perfecto para relajarse y disfrutar del paisaje.
        """
        label.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(label)
        
        // Configurar restricciones para la UILabel dentro del contentView
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
