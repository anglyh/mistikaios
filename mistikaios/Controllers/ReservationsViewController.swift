//
//  ReservationsViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//
// ReservationsViewController.swift


import UIKit
import FirebaseAuth

class ReservationsViewController: UIViewController {
    
    var tableViewManager: TableViewManager?
    var userReservations: [Reservation] = [] // Aquí almacenaremos las reservas del usuario
    
    @IBOutlet weak var tbl_reservations: UITableView!
    @IBOutlet weak var tbl_reservationsHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializa el TableViewManager
        tableViewManager = TableViewManager(tableView: tbl_reservations, heightConstraint: tbl_reservationsHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Comprobamos si el usuario está logeado
        if (Auth.auth().currentUser?.uid) != nil {
            // Si está logeado, obtenemos las reservas para ese usuario
            ReservationService.getUserReservations { reservations, error in
                if let error = error {
                    // Si ocurre un error, mostramos una alerta
                    AlertManager.showErrorAlert(from: self, message: "No se pudieron cargar las reservas: \(error.localizedDescription)")
                    return
                }
                
                // Guardamos las reservas obtenidas y recargamos la tabla
                self.userReservations = reservations ?? []
                self.tbl_reservations.reloadData()
            }
        } else {
            // En caso que no esté logeado (aunque dijiste que esto no debería pasar)
            AlertManager.showErrorAlert(from: self, message: "Por favor, inicia sesión para ver tus reservas.")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Elimina el observador cuando la vista desaparezca
        tableViewManager?.removeObserver()
    }
}

extension ReservationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReservations.count // Mostramos las reservas del usuario
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as? ReservationCell {
            let reservation = userReservations[indexPath.row]
            cell.lbl_reservationPlace.text = reservation.businessTitle
            cell.lbl_reservationNameuser.text = reservation.fullName
            cell.lbl_reservationPhoneNumber.text = reservation.phoneNumber
            cell.lbl_reservationDate.text = reservation.date
            cell.lbl_reservationNumberPersons.text = "\(reservation.numberOfPeople)"
            return cell
        }
        return UITableViewCell() // Si no se puede obtener la celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
