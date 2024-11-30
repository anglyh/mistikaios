//
//  Event.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import FirebaseFirestore
import Firebase

// Estructura para representar el campo 'location'
struct Location {
    var address: String
    var coordinates: [Double] // Coordenadas como un array [longitud, latitud]
}

struct Event {
    var capacity: Int
    var date: Date
    var description: String
    var imageUri: String
    var location: Location
    var price: Int
    var title: String

    // Inicializador que acepta un QueryDocumentSnapshot
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()

        guard let capacity = data["capacity"] as? Int,
              let dateTimestamp = data["date"] as? Timestamp,
              let description = data["description"] as? String,
              let imageUri = data["imageUri"] as? String,
              let locationData = data["location"] as? [String: Any],
              let address = locationData["address"] as? String,
              let coordinates = locationData["coordinates"] as? [Double],
              let price = data["price"] as? Int,
              let title = data["title"] as? String else {
            print("Error: No se pudieron mapear todos los campos de Event.")
            return nil
        }

        // Convertir el Timestamp a Date
        self.capacity = capacity
        self.date = dateTimestamp.dateValue()
        self.description = description
        self.imageUri = imageUri
        self.location = Location(address: address, coordinates: coordinates)  // Asignar la localización
        self.price = price
        self.title = title
    }
}
