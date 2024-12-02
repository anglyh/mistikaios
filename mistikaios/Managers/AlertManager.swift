//
//  AlertManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 1/12/24.
//

import UIKit

class AlertManager {
    
    // Función para mostrar una alerta genérica
    static func showAlert(from viewController: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // Función para mostrar una alerta de éxito
    static func showSuccessAlert(from viewController: UIViewController, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Éxito", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // Función para mostrar una alerta de advertencia
    static func showWarningAlert(from viewController: UIViewController, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Advertencia", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // Función para mostrar una alerta de error
    static func showErrorAlert(from viewController: UIViewController, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
