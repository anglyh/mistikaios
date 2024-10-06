//
//  MainViewController.swift
//  mistikaios
//
//  Created by angel on 5/10/24.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingView()
        view.addSubview(loadingView)
        
        // Comprobar el estado de inicio de sesión después de un pequeño retraso
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.checkLoginStatus()
        }
    }
    
    private func setupLoadingView() {
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor.white // Color de fondo de la vista de carga
        
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(logoImageView)
        
        // Constraints para centrar el logo
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -20), // Ajusta la posición si es necesario
            logoImageView.widthAnchor.constraint(equalToConstant: 100), // Ancho del logo
            logoImageView.heightAnchor.constraint(equalToConstant: 100) // Alto del logo
        ])
        
        // Indicador de actividad
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        
        // Constraints para centrar el indicador de actividad
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20) // Espacio entre el logo y el indicador
        ])
    }
    
    private func checkLoginStatus() {
        // Aquí deberías implementar la lógica para comprobar el estado de inicio de sesión.
        Auth.auth().currentUser != nil ? navigateToHome() : navigateToLogin()
    }
    
    private func navigateToHome() {
        // Ocultar la vista de carga y navegar a la pantalla de inicio
        loadingView.removeFromSuperview()
        performSegue(withIdentifier: "homeScreen", sender: self)
    }

    private func navigateToLogin() {
        // Ocultar la vista de carga y navegar a la pantalla de inicio de sesión
        loadingView.removeFromSuperview()
        performSegue(withIdentifier: "goToLoginScreen", sender: self)
    }
}
