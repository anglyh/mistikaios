//
//  ReservationsViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit

class ReservationsViewController: UIViewController {
    
    var tableViewManager: TableViewManager?

    @IBOutlet weak var tbl_reservations: UITableView!
    @IBOutlet weak var tbl_reservationsHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicializa el TableViewManager
        tableViewManager = TableViewManager(tableView: tbl_reservations, heightConstraint: tbl_reservationsHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Recarga los datos de la tabla cuando la vista aparece
        self.tbl_reservations.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Elimina el observador cuando la vista desaparezca
        tableViewManager?.removeObserver()
    }

}

extension ReservationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as? ReservationCell {
            cell.lbl_reservationPayments.text = "\(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
}
