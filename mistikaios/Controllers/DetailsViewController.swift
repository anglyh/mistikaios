//
//  DetailsViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit
import WebKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lbl_negocioName: UILabel!
    @IBOutlet weak var img_negocioImage: UIImageView!
    @IBOutlet weak var lbl_negocioType: UILabel!
    @IBOutlet weak var lbl_negocioUbication: UILabel!
    @IBOutlet weak var wview_negocioUrl: WKWebView!
    
    // Propiedad para recibir los datos del negocio
    var business: Business?
    //titulo del negocio
    var businessTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asegurarse de que los datos están disponibles
        if let business = business {
            lbl_negocioName.text = business.name  // Usamos business.name directamente
            
            lbl_negocioType.text = business.typeBusiness
            
            // Usamos ImageLoader para cargar y darle estilo a la imagen
            ImageLoader.loadImage(from: business.image, into: img_negocioImage)
            
            // Mostrar la URL
            if let url = URL(string: business.url) {
                let request = URLRequest(url: url)
                wview_negocioUrl.load(request)
            }
            
            // Convertir coordenadas de latitud y longitud a una dirección y actualizar la UI
            let location = CLLocation(latitude: business.ubication.latitude, longitude: business.ubication.longitude)

            // Usar GeocoderManager para geocodificar la ubicación y actualizar la UI
            GeocoderManager.geocodeLocation(location, label: lbl_negocioUbication)
        }
    }
    
    // Segue para pasar a la pantalla de reserva
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMakeReservation", let destination = segue.destination as? MakeReservationViewController {
            // Pasamos el título del negocio a la vista de reserva
            destination.businessTitle = self.business?.name  // Asegúrate de pasar el nombre correcto
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
