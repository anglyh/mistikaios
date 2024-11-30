//
//  EventosViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 8/11/24.
//

import UIKit

class EventosViewController: UIViewController {

    var menuManager: MenuManager!
    var tableViewManager: TableViewManager?
    var events: [Event] = []  // Lista de eventos
    
    @IBOutlet weak var tbl_events: UITableView!
    @IBOutlet weak var tlb_eventsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var img_eventRandom: UIImageView!
    @IBOutlet weak var lbl_eventRandom: UILabel!
    
    
    let eventService = EventService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración inicial
        NavigationBarManager.setupTitle(in: self, title: "Mistika")
        menuManager = MenuManager(parentViewController: self)
        menuManager.setupMenu()
        tableViewManager = TableViewManager(tableView: tbl_events, heightConstraint: tlb_eventsHeight)
        
        //Configurar el formato de la imagen
        img_eventRandom.contentMode = .scaleAspectFill
        img_eventRandom.layer.cornerRadius = 15
        img_eventRandom.clipsToBounds = true
        
        // Obtener los eventos
        fetchEvents()
    }
    
    // Método para obtener los eventos
    func fetchEvents() {
        eventService.getEvents { [weak self] events, error in
            if let error = error {
                print("Error al obtener los eventos: \(error.localizedDescription)")
            } else {
                print("Eventos obtenidos correctamente")
                self?.events = events ?? []
                self?.tbl_events.reloadData()
                
                // Mostrar un evento aleatorio en el UIImageView y el UILabel
                self?.showRandomEvent()
            }
        }
    }
    
    // Mostrar un evento aleatorio en el UIImageView y el UILabel
    func showRandomEvent() {
        // Verificar si hay eventos cargados
        if events.isEmpty {
            return
        }
        
        // Seleccionar un evento aleatorio
        let randomEvent = events.randomElement()
        
        if let event = randomEvent {
            // Actualizar el título en el UILabel
            lbl_eventRandom.text = event.title
            
            // Cargar la imagen desde la URL del evento
            if let url = URL(string: event.imageUri) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.img_eventRandom.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        menuManager.toggleMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbl_events.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableViewManager?.removeObserver()
    }
}

extension EventosViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
            let event = events[indexPath.row]
            cell.lbl_eventTitle.text = event.title
            // Mostrar fecha con formato
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            cell.lbl_eventDate.text = dateFormatter.string(from: event.date) // Aquí ya no es necesario usar `if let`
                    
            // Mostrar lugar (dirección)
            cell.lbl_eventPlace.text = event.location.address
                    
            // Mostrar hora del evento (si tienes un campo separado de hora o si la fecha incluye hora)
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "h:mm a"  // Formato de hora
            cell.lbl_eventHour.text = hourFormatter.string(from: event.date)
            
            // Cargar imagen desde URL
            if let url = URL(string: event.imageUri) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.img_eventImage.image = image
                        }
                    }
                }.resume()
            }
            
            return cell
        }
        return UITableViewCell()
    }
}
