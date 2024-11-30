//
//  TableViewManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit

class TableViewManager: NSObject {
    
    weak var tableView: UITableView?
    weak var heightConstraint: NSLayoutConstraint?
    
    init(tableView: UITableView, heightConstraint: NSLayoutConstraint) {
        self.tableView = tableView
        self.heightConstraint = heightConstraint
        super.init()
        self.setupObserver()
    }
    
    // Configura el observador para la propiedad contentSize de la tabla
    private func setupObserver() {
        // Verifica que la tabla no sea nil antes de agregar el observador
        guard let tableView = tableView else { return }
        
        // Agrega el observador solo si no está agregado previamente
        if !isObserving() {
            tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }
    }
    
    // Verifica si ya estamos observando el contenido
    private func isObserving() -> Bool {
        // Implementa una forma de saber si ya hemos agregado el observador
        return self.tableView?.observationInfo != nil
    }
    
    // Elimina el observador cuando ya no sea necesario
    func removeObserver() {
        guard let tableView = tableView else { return }
        
        // Solo elimina el observador si está registrado
        if isObserving() {
            tableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    // Se llama cuando se detecta un cambio en contentSize de la tabla
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] as? CGSize {
                self.heightConstraint?.constant = newValue.height
            }
        }
    }
}

