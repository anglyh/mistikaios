//
//  Reservation.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import Foundation

// Implementamos Codable para que se pueda convertir fácilmente a/from Firebase
struct Reservation: Codable {
    var fullName: String
    var phoneNumber: String
    var date: String
    var numberOfPeople: Int
    var businessTitle: String
    
    // Inicializador para facilitar la creación de instancias
    init(fullName: String, phoneNumber: String, date: String, numberOfPeople: Int, businessTitle: String) {
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.date = date
        self.numberOfPeople = numberOfPeople
        self.businessTitle = businessTitle
    }
    
    // Inicializador adicional para usar los datos de Firebase de forma más directa
    init?(from dictionary: [String: Any]) {
        guard let fullName = dictionary["fullName"] as? String,
              let phoneNumber = dictionary["phoneNumber"] as? String,
              let date = dictionary["date"] as? String,
              let numberOfPeople = dictionary["numberOfPeople"] as? Int,
              let businessTitle = dictionary["businessTitle"] as? String else {
            return nil
        }
        
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.date = date
        self.numberOfPeople = numberOfPeople
        self.businessTitle = businessTitle
    }
}
