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
            
            // Si faltan datos, mostrar un alerta
            showAlert(title: "Error", message: "Por favor, complete todos los campos.")
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
        let ref = Database.database().reference().child("reservations").childByAutoId()  // Genera un ID único
        ref.setValue([
            "fullName": reservation.fullName,
            "phoneNumber": reservation.phoneNumber,
            "date": reservation.date,
            "numberOfPeople": reservation.numberOfPeople,
            "businessTitle": reservation.businessTitle
        ]) { (error, _) in
            if let error = error {
                // Si ocurre un error al guardar
                print("Error al guardar la reserva: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Hubo un problema al guardar la reserva. Inténtalo de nuevo.")
            } else {
                // Si la reserva se guarda correctamente
                print("Reserva guardada exitosamente.")
                self.showSuccessAlert()
            }
        }
    }
    
    // Función para mostrar una alerta genérica
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Función para mostrar una alerta de éxito
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Reserva exitosa", message: "Tu reserva ha sido realizada correctamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
