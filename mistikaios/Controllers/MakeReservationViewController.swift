//
//  MakeReservationViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit
import Firebase

class MakeReservationViewController: UIViewController {
    
    @IBOutlet weak var lbl_businessTitle: UILabel!
    @IBOutlet weak var txt_fullName: UITextField!
    @IBOutlet weak var txt_phoneNumber: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txt_numberPersons: UITextField!
    
    var businessTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mostrar el título del negocio en el label
        if let title = businessTitle {
            lbl_businessTitle.text = title
        }
    }
    
    @IBAction func btnMakeReserva(_ sender: Any) {
        // Obtener los valores de los campos
        guard let fullName = txt_fullName.text, !fullName.isEmpty,
              let phoneNumber = txt_phoneNumber.text, !phoneNumber.isEmpty,
              let numberOfPeople = txt_numberPersons.text, let numPeople = Int(numberOfPeople), numPeople > 0 else {
            
            // Si faltan datos, mostrar una alerta
            AlertManager.showErrorAlert(from: self, message: "Por favor, complete todos los campos.")
            return
        }
        
        // Convertir la fecha seleccionada a formato adecuado
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        
        // Crear un objeto de reserva
        let reservation = Reservation(fullName: fullName, phoneNumber: phoneNumber, date: formattedDate, numberOfPeople: numPeople, businessTitle: businessTitle ?? "Desconocido")
        
        // Guardar la reserva en Firebase
        saveReservation(reservation)
    }
    
    // Función para guardar la reserva en Firebase Realtime Database
    func saveReservation(_ reservation: Reservation) {
        // Primero obtenemos el UID del usuario actual
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: No se pudo obtener el UID del usuario.")
            return
        }
        
        let ref = Database.database().reference()
        
        // Guardamos la reserva en el nodo del usuario
        let userReservationsRef = ref.child("users").child(userId).child("reservations").childByAutoId()
        userReservationsRef.setValue([
            "fullName": reservation.fullName,
            "phoneNumber": reservation.phoneNumber,
            "date": reservation.date,
            "numberOfPeople": reservation.numberOfPeople,
            "businessTitle": reservation.businessTitle
        ]) { (error, _) in
            if let error = error {
                // Si ocurre un error al guardar, mostrar una alerta de error
                print("Error al guardar la reserva: \(error.localizedDescription)")
                AlertManager.showErrorAlert(from: self, message: "Hubo un problema al guardar la reserva. Inténtalo de nuevo.")
            } else {
                // Si la reserva se guarda correctamente, mostrar alerta de éxito
                print("Reserva guardada exitosamente.")
                AlertManager.showSuccessAlert(from: self, message: "Tu reserva ha sido realizada correctamente.")
            }
        }
    }
}
