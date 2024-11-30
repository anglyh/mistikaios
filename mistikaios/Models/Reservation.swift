//
//  Reservation.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import Foundation

struct Reservation {
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
}
