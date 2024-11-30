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
        img_negocioImage.contentMode = .scaleAspectFill  // Esto ayudará a mantener la proporción de la imagen
        img_negocioImage.layer.cornerRadius = 15
        img_negocioImage.clipsToBounds = true
        
        // Asegurarse de que los datos están disponibles
        if let business = business {
            lbl_negocioName.text = business.name  // Usamos business.name directamente
            
            lbl_negocioType.text = business.typeBusiness
            
            // Cargar imagen
            if let url = URL(string: business.image) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.img_negocioImage.image = image
                        }
                    }
                }.resume()
            }
            
            // Mostrar la URL
            if let url = URL(string: business.url) {
                let request = URLRequest(url: url)
                wview_negocioUrl.load(request)
            }
            
            // Convertir coordenadas de latitud y longitud a una dirección
            let location = CLLocation(latitude: business.ubication.latitude, longitude: business.ubication.longitude)
            geocodeLocation(location)
        }
    }
    
    // Función para convertir la latitud y longitud en una dirección
    func geocodeLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error al geocodificar la ubicación: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                var address = ""
                if let street = placemark.thoroughfare {
                    address += street + ", "
                }
                if let city = placemark.locality {
                    address += city + ", "
                }
                if let country = placemark.country {
                    address += country
                }
                DispatchQueue.main.async {
                    self.lbl_negocioUbication.text = address
                }
            }
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
