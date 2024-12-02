//
//  GeocoderManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 1/12/24.
//

import Foundation
import CoreLocation
import UIKit

class GeocoderManager {
    
    // Función para convertir coordenadas (latitud, longitud) en una dirección y actualizar la UI
    static func geocodeLocation(_ location: CLLocation, label: UILabel) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                // Manejo del error y actualización de la UI
                DispatchQueue.main.async {
                    label.text = "Error al geocodificar la ubicación: \(error.localizedDescription)"
                }
                return
            }
            
            if let placemark = placemarks?.first {
                var address = ""
                
                // Construir la dirección
                if let street = placemark.thoroughfare {
                    address += street + ", "
                }
                if let city = placemark.locality {
                    address += city + ", "
                }
                if let country = placemark.country {
                    address += country
                }
                
                // Actualizar la UI con la dirección
                DispatchQueue.main.async {
                    label.text = address
                }
            } else {
                // Si no se obtuvo dirección, mostrar un mensaje
                DispatchQueue.main.async {
                    label.text = "Dirección no disponible"
                }
            }
        }
    }
}

