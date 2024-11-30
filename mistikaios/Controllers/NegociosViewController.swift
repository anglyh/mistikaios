//
//  NegociosViewController.swift
//  mistikaios
//
//  Created by Deivid Jhon Del Carpio Vilca on 18/11/24.
//

import UIKit
import FirebaseFirestore

class NegociosViewController: UIViewController {

    var menuManager: MenuManager!
    var tableViewManager: TableViewManager?
    var businesses: [Business] = []
    let businessService = BusinessService()
    
    @IBOutlet weak var tbl_negocios: UITableView!
    @IBOutlet weak var tlb_negociosHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicializar la función para agregar el título
        NavigationBarManager.setupTitle(in: self, title: "Mistika")
        // Inicializar el MenuManager
        menuManager = MenuManager(parentViewController: self)
        // Configurar el menú
        menuManager.setupMenu()
        // Inicializa el TableViewManager
        tableViewManager = TableViewManager(tableView: tbl_negocios, heightConstraint: tlb_negociosHeight)
        
        fetchBusinesses()
    }
    
    func fetchBusinesses() {
        businessService.fetchBusinesses { [weak self] businesses in
            print("Datos de negocios: \(businesses)")
            self?.businesses = businesses
            print("Fetched businesses: \(businesses.count)")  
            self?.tbl_negocios.reloadData()
        }
    }
    
    // Método que se llama al tocar el botón del menú
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        menuManager.toggleMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Recarga los datos de la tabla cuando la vista aparece
        self.tbl_negocios.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Elimina el observador cuando la vista desaparezca
        tableViewManager?.removeObserver()
    }
}

extension NegociosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NegocioCell", for: indexPath) as? NegocioCell {
            let business = businesses[indexPath.row]
            cell.lbl_negocioTitle.text = business.name
            
            // Cargar imagen desde URL
            if let url = URL(string: business.image) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.img_negocioImage.image = image
                        }
                    }
                }.resume()
            }

            return cell
        }
        return UITableViewCell()  // En caso de que no se pueda obtener la celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business = businesses[indexPath.row]
        performSegue(withIdentifier: "showDetailsSegue", sender: business)
    }
        
    // Preparar el paso de datos al siguiente ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue", let destinationVC = segue.destination as? DetailsViewController {
            if let business = sender as? Business {
                destinationVC.business = business  // Pasa el objeto 'business' al siguiente ViewController
            }
        }
    }
}

