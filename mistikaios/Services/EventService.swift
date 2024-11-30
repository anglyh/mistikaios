//
//  EventService.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 29/11/24.
//

import FirebaseFirestore
import Firebase

class EventService {
    
    private let db = Firestore.firestore()
    
    // Función para obtener todos los eventos de la colección "eventos"
    func getEvents(completion: @escaping ([Event]?, Error?) -> Void) {
        db.collection("eventos").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching events from Firestore: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            print("Successfully fetched documents from Firestore.")
            
            var events: [Event] = []
            
            // Verificar si snapshot contiene documentos
            if let snapshot = snapshot {
                print("Total documents found: \(snapshot.documents.count)")
                
                for document in snapshot.documents {
                    print("Processing document: \(document.documentID)")
                    
                    if let event = Event(document: document) {
                        print("Event successfully created: \(event.title)")
                        events.append(event)
                    } else {
                        print("Failed to map document to Event model")
                    }
                }
            } else {
                print("Snapshot is nil.")
            }
            
            // Completar el closure con la lista de eventos
            completion(events, nil)
        }
    }
}
