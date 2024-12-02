//
//  ReservationService.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ReservationService {
    
    // Función para guardar una reserva
    static func saveReservation(_ reservation: Reservation, completion: @escaping (Error?) -> Void) {
        // Primero obtenemos el UID del usuario actual
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: No se pudo obtener el UID del usuario.")
            return
        }
        
        let ref = Database.database().reference()
        
        // Guardamos la reserva en el nodo del usuario
        let userReservationsRef = ref.child("users").child(userId).child("reservations").childByAutoId()
        
        // Convertir la reserva a un diccionario para guardar en Firebase
        let reservationDict: [String: Any] = [
            "fullName": reservation.fullName,
            "phoneNumber": reservation.phoneNumber,
            "date": reservation.date,
            "numberOfPeople": reservation.numberOfPeople,
            "businessTitle": reservation.businessTitle
        ]
        
        // Guardamos la reserva en la base de datos
        userReservationsRef.setValue(reservationDict) { (error, _) in
            completion(error)
        }
    }
    
    // Función para obtener las reservas del usuario
    static func getUserReservations(completion: @escaping ([Reservation]?, Error?) -> Void) {
        // Primero obtenemos el UID del usuario actual
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: No se pudo obtener el UID del usuario.")
            return
        }
        
        let ref = Database.database().reference()
        
        // Obtenemos las reservas del usuario desde Firebase
        ref.child("users").child(userId).child("reservations").observeSingleEvent(of: .value) { snapshot in
            var reservations: [Reservation] = []
            
            // Verificamos si hay datos
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let dict = snapshot.value as? [String: Any] {
                    // Convertimos el diccionario en un objeto de tipo Reservation
                    if let reservation = Reservation(from: dict) {
                        reservations.append(reservation)
                    }
                }
            }
            
            // Devolvemos las reservas
            completion(reservations, nil)
        }
    }
}
