//
//  MenuManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 27/11/24.
//

import UIKit

class MenuManager {
    
    var menuIsVisible = false
    var menuWidth: CGFloat = 300
    var menuView: UIView!
    var parentViewController: UIViewController!
    
    init(parentViewController: UIViewController, menuWidth: CGFloat = 300) {
        self.parentViewController = parentViewController
        self.menuWidth = menuWidth
    }
    
    // Método para configurar el menú lateral
    func setupMenu() {
        menuView = UIView(frame: CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.parentViewController.view.frame.height))
        menuView.backgroundColor = .gray
        
        // Agregar el SidebarViewController como hijo
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let sidebarVC = storyboard.instantiateViewController(withIdentifier: "SidebarViewController") as? SidebarViewController {
            parentViewController.addChild(sidebarVC)
            sidebarVC.view.frame = menuView.bounds
            menuView.addSubview(sidebarVC.view)
            sidebarVC.didMove(toParent: parentViewController)
        }
        
        // Añadir el menú a la vista principal
        self.parentViewController.view.addSubview(menuView)
        
        // Añadir gesto de deslizamiento para cerrar el menú
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .left
        self.parentViewController.view.addGestureRecognizer(swipeGesture)
    }
    
    // Método para mostrar y ocultar el menú lateral con animación suave
    func toggleMenu() {
        menuIsVisible.toggle()
        
        // Definir la posición final del menú lateral
        let targetPosition = menuIsVisible ? 0 : -menuWidth
        
        // Animar el deslizamiento del menú con una transición uniforme
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.menuView.frame.origin.x = targetPosition
        }, completion: nil)
    }
    
    // Método para manejar el gesto de deslizamiento y ocultar el menú
    @objc func handleSwipeGesture() {
        if menuIsVisible {
            toggleMenu()  // Cierra el menú si está abierto
        }
    }
}

