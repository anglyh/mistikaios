//
//  NavigationBarManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 27/11/24.
//

import UIKit

class NavigationBarManager {
    
    static func setupTitle(in viewController: UIViewController, title: String) {
        // Crear el UILabel para el título
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(red: 0.15, green: 0.2, blue: 0.6, alpha: 1.0)
        
        // Crear el UIBarButtonItem con el UILabel
        let titleItem = UIBarButtonItem(customView: titleLabel)
        
        // Asignar el UIBarButtonItem a la barra de navegación
        viewController.navigationItem.rightBarButtonItems = [titleItem]
    }
}
