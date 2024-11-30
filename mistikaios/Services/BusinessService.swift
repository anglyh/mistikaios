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
    
    func fetchBusinesses(completion: @escaping ([Business]) -> Void) {
        db.collection("business")
            .getDocuments { (snapshot, error) in
                var businesses: [Business] = []
                
                if let error = error {
                    print("Error fetching businesses: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    print("Snapshot obtenido con \(snapshot.documents.count) documentos.")
                } else {
                    print("El snapshot está vacío.")
                }
                
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    
                    if let id = document.documentID as String?,
                       let name = data["name"] as? String,
                       let image = data["image"] as? String,
                       let typeBusiness = data["typeBusiness"] as? String,
                       let ubication = data["ubication"] as? [Double],
                       let url = data["url"] as? String {
                        
                        let business = Business(id: id, image: image, name: name, typeBusiness: typeBusiness, ubication: CLLocationCoordinate2D(latitude: ubication[0], longitude: ubication[1]), url: url)
                        
                        businesses.append(business)
                    } else {
                        print("Documento con datos incompletos: \(document.documentID)")
                    }
                }
                
                print("Negocios obtenidos: \(businesses.count)")
                completion(businesses)
            }
    }

}

