//
//  DateFormatterManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 1/12/24.
//

import Foundation

class DateFormatterManager {
    
    // Función para formatear una fecha completa
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    // Función para formatear la hora
    static func formatHour(_ date: Date) -> String {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h:mm a"  // Formato de hora
        return hourFormatter.string(from: date)
    }
}
