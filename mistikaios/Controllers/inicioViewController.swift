//
//  inicioViewController.swift
//  mistikaios
//
//  Created by David Quispe Maqque on 30/10/24.
//

import UIKit

import SwiftUI
import MapKit
import CoreLocation

class inicioViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var menuManager: MenuManager!
    @IBOutlet weak var mapView: MKMapView!
    
    let startingLocation = CLLocationCoordinate2D(latitude: -16.398803, longitude: -71.536886) // Plaza de Armas de Arequipa
        var localSearch: MKLocalSearch? // Para cancelar la búsqueda anterior si es necesario

        override func viewDidLoad() {
            super.viewDidLoad()
            // Inicializar la función para agregar el título
            NavigationBarManager.setupTitle(in: self, title: "Mistika")
            // Inicializar el MenuManager
            menuManager = MenuManager(parentViewController: self)
            // Configurar el menú
            menuManager.setupMenu()
            
            mapView.delegate = self
            mapView.showsUserLocation = false // No depende de la ubicación del usuario real
            centerMapOnLocation(location: startingLocation)
            
            // Añadir un pin visible en la ubicación de partida
            let startAnnotation = MKPointAnnotation()
            startAnnotation.coordinate = startingLocation
            startAnnotation.title = "Ubicación Actual"
            mapView.addAnnotation(startAnnotation)
            
            // Añadir un gesto de toque para seleccionar el destino en el mapa
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
            mapView.addGestureRecognizer(tapGesture)
        }
    
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        menuManager.toggleMenu()
    }
        
        // Centra el mapa en una ubicación específica
        func centerMapOnLocation(location: CLLocationCoordinate2D) {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
        
        // Maneja el toque en el mapa para seleccionar el destino
        @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let locationInView = gestureRecognizer.location(in: mapView)
            let destinationCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            // Limpia cualquier ruta o anotación previa
            mapView.removeOverlays(mapView.overlays)
            mapView.removeAnnotations(mapView.annotations)
            
            // Añade un pin visible en el destino seleccionado
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.coordinate = destinationCoordinate
            destinationAnnotation.title = "Destino"
            mapView.addAnnotation(destinationAnnotation)
            
            // Añadir nuevamente el pin en la ubicación de partida
            let startAnnotation = MKPointAnnotation()
            startAnnotation.coordinate = startingLocation
            startAnnotation.title = "Ubicación Actual"
            mapView.addAnnotation(startAnnotation)
            
            // Calcular la ruta hacia el destino
            calculateRoute(to: destinationCoordinate)
        }
        
        // Calcula la ruta desde la Plaza de Armas hasta el destino seleccionado
        func calculateRoute(to destination: CLLocationCoordinate2D) {
            let startPlacemark = MKPlacemark(coordinate: startingLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destination)
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: startPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            request.transportType = .automobile

            let directions = MKDirections(request: request)
            directions.calculate { [weak self] (response, error) in
                guard let self = self else { return }
                guard let route = response?.routes.first, error == nil else {
                    print("Error al calcular la ruta: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                
                // Añadir la ruta al mapa
                self.mapView.addOverlay(route.polyline)
                
                // Ajustar el mapa para mostrar toda la ruta
                let routeRect = route.polyline.boundingMapRect
                self.mapView.setVisibleMapRect(routeRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
        
        // Delegate de MKMapView para renderizar la línea de la ruta
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let polylineRenderer = MKPolylineRenderer(overlay: overlay)
                polylineRenderer.strokeColor = .blue
                polylineRenderer.lineWidth = 4
                return polylineRenderer
            }
            return MKOverlayRenderer()
        }

        // Acción para buscar Restaurantes
        @IBAction func searchRestaurants(_ sender: UIButton) {
            searchNearby(category: "restaurant")
        }
        
        // Acción para buscar Lugares Turísticos
        @IBAction func searchTouristSpots(_ sender: UIButton) {
            searchNearby(category: "tourist attraction")
        }
        
        // Acción para buscar Hoteles
        @IBAction func searchHotels(_ sender: UIButton) {
            searchNearby(category: "hotel")
        }
        
        // Realiza una búsqueda local en base a la categoría seleccionada
        func searchNearby(category: String) {
            // Cancelar cualquier búsqueda anterior
            localSearch?.cancel()
            
            // Crear la solicitud de búsqueda
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = category
            request.region = mapView.region
            
            // Realizar la búsqueda
            localSearch = MKLocalSearch(request: request)
            localSearch?.start { [weak self] (response, error) in
                guard let self = self else { return }
                guard let response = response, error == nil else {
                    print("Error en la búsqueda local: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                
                // Eliminar anotaciones anteriores
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                // Añadir una anotación por cada resultado encontrado
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
