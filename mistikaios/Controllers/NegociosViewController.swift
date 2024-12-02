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
    var filteredBusinesses: [Business] = []  // Lista filtrada de negocios
    let businessService = BusinessService()
    
    @IBOutlet weak var tbl_negocios: UITableView!
    @IBOutlet weak var tlb_negociosHeight: NSLayoutConstraint!
    @IBOutlet weak var seg_negociosControl: UISegmentedControl!
    @IBOutlet weak var search_negociosBar: UISearchBar!
    
    // Tipo de negocio actual
    var currentBusinessType: String = "restaurantes"
          
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
        
        // Configurar el SearchBar
        search_negociosBar.delegate = self  // Asignamos el delegado al ViewController
        
        fetchBusinesses()
    }
    
    // Método para manejar el cambio en el Segment Control
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentBusinessType = "restaurantes"
        case 1:
            currentBusinessType = "hoteles"
        case 2:
            currentBusinessType = "agencias"
        default:
            break
        }
        // Filtrar y actualizar la tabla con el tipo de negocio seleccionado
        fetchBusinesses()
    }
    
    // Método para obtener los negocios filtrados según el tipo
    func fetchBusinesses() {
        businessService.fetchBusinesses(ofType: currentBusinessType) { [weak self] businesses in
            self?.businesses = businesses
            self?.filteredBusinesses = businesses  // Inicialmente, los negocios filtrados son todos los negocios
            self?.tbl_negocios.reloadData()  // Recargar la tabla después de obtener los datos
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
        return filteredBusinesses.count  // Usar la lista filtrada
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NegocioCell", for: indexPath) as? NegocioCell {
            let business = filteredBusinesses[indexPath.row]  // Mostrar los negocios filtrados
            cell.lbl_negocioTitle.text = business.name
            
            // Usamos ImageLoader para cargar y darle estilo a la imagen
            ImageLoader.loadImage(from: business.image, into: cell.img_negocioImage)
            
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
        let business = filteredBusinesses[indexPath.row]
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

extension NegociosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Utilizamos el BusinessSearchManager para filtrar los negocios
        filteredBusinesses = BusinessSearchManager.filterBusinesses(businesses, with: searchText)
        
        // Recargamos la tabla para mostrar los resultados filtrados
        tbl_negocios.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Si el usuario cancela la búsqueda, se muestran todos los negocios
        searchBar.text = ""
        filteredBusinesses = businesses
        tbl_negocios.reloadData()
    }
}
