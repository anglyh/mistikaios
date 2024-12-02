//
//  BusinessService.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import FirebaseFirestore
import CoreLocation

class BusinessService {
    
    private let db = Firestore.firestore()
    
    // Este método ahora obtiene los negocios desde Firestore
    func fetchBusinesses(ofType type: String, completion: @escaping ([Business]) -> Void) {
        db.collection("business")
            .whereField("typeBusiness", isEqualTo: type) // Filtrar por tipo de negocio
            .getDocuments { (snapshot, error) in
                var businesses: [Business] = []
                
                // Manejo de errores en caso de que no se pueda obtener la información
                if let error = error {
                    print("Error al obtener negocios: \(error.localizedDescription)")
                    completion([])  // Pasamos un array vacío si hay error
                    return
                }
                
                // Verificamos si el snapshot está vacío
                if let snapshot = snapshot {
                    print("Snapshot obtenido con \(snapshot.documents.count) documentos.")
                } else {
                    print("El snapshot está vacío.")
                    completion([]) // Si no hay documentos, pasamos un array vacío
                    return
                }
                
                // Iteramos sobre los documentos obtenidos del snapshot
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    
                    // Intentamos extraer los datos del documento
                    if let id = document.documentID as String?,
                       let name = data["name"] as? String,
                       let image = data["image"] as? String,
                       let typeBusiness = data["typeBusiness"] as? String,
                       let ubication = data["ubication"] as? [Double],
                       let url = data["url"] as? String {
                        
                        // Creamos el objeto Business con los datos extraídos
                        let business = Business(id: id,
                                                 image: image,
                                                 name: name,
                                                 typeBusiness: typeBusiness,
                                                 ubication: CLLocationCoordinate2D(latitude: ubication[0], longitude: ubication[1]),
                                                 url: url)
                        
                        businesses.append(business)
                    } else {
                        print("Documento con datos incompletos: \(document.documentID)")
                    }
                }
                
                // Imprimimos la cantidad de negocios obtenidos
                print("Negocios obtenidos: \(businesses.count)")
                
                // Llamamos a completion con los negocios obtenidos
                completion(businesses)
            }
    }
}

