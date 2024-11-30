//
//  Business.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct Business {
    var id: String
    var image: String
    var name: String
    var typeBusiness: String
    var ubication: CLLocationCoordinate2D
    var url: String
    
    init(id: String, image: String, name: String, typeBusiness: String, ubication: CLLocationCoordinate2D, url: String) {
        self.id = id
        self.image = image
        self.name = name
        self.typeBusiness = typeBusiness
        self.ubication = ubication
        self.url = url
    }
    
    // Función para convertir el modelo Business en un diccionario que puede ser almacenado en Firestore
    func toDictionary() -> [String: Any] {
        return [
            "image": image,
            "name": name,
            "typeBusiness": typeBusiness,
            "ubication": GeoPoint(latitude: ubication.latitude, longitude: ubication.longitude),
            "url": url
        ]
    }
}

