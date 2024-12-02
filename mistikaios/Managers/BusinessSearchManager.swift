//
//  BusinessSearchManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 30/10/24.
//

import Foundation

class BusinessSearchManager {
    
    // Método para filtrar negocios por nombre
    static func filterBusinesses(_ businesses: [Business], with searchText: String) -> [Business] {
        if searchText.isEmpty {
            return businesses  // Si el campo de búsqueda está vacío, devolver todos los negocios
        } else {
            return businesses.filter { business in
                // Filtramos por nombre de negocio, ignorando mayúsculas y minúsculas
                return business.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
