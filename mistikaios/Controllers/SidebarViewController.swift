//
//  SidebarViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 26/11/24.
//

import UIKit
import FirebaseAuth

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableview: UITableView!

    // Definir las opciones del menú
    var menuItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Verificar si el usuario está autenticado
        if Auth.auth().currentUser != nil {
            // Usuario logueado, agregar "Reservas" y "Cerrar sesión"
            menuItems = ["Reservas", "Cerrar sesión"]
        } else {
            // Usuario no logueado, solo "Iniciar sesión"
            menuItems = ["Iniciar sesión"]
        }

        // Configurar el UITableView
        menuTableview.delegate = self
        menuTableview.dataSource = self
    }

    // Método para determinar cuántas filas hay en el UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // Método para configurar cada celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuItems[indexPath.row] == "Cerrar sesión" ? "cerrarsesionCell" : "reservasCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    // Manejar la selección de un item del menú
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row]
        
        if selectedItem == "Reservas" {
            // Realizar segue hacia la vista de reservas
            performSegue(withIdentifier: "goToReservations", sender: self)
        }
        
        if selectedItem == "Cerrar sesión" {
            // Cerrar sesión
            do {
                try Auth.auth().signOut()
                // Redirigir al login
                redirectToLogin()
            } catch let error {
                print("Error al cerrar sesión: \(error.localizedDescription)")
            }
        }
        
        // Deseleccionar la celda
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Función para redirigir al Login
    func redirectToLogin() {
        // Realizar el proceso de cierre de sesión
        do {
            try Auth.auth().signOut()
            
            // Llamar al método del SceneDelegate para hacer reset
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.resetToLoginViewController()
            }
            
        } catch let error {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}
