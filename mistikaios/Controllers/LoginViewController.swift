//
//  ViewController.swift
//  mistikaios
//
//  Created by angel on 5/10/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email: String?
    var password: String?
    
    private var hasNavigatedToHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Verificar si el usuario ya está autenticado
        if let currentUser = Auth.auth().currentUser, !hasNavigatedToHome {
            navigateToHome(withEmail: currentUser.email ?? "Usuario")
            hasNavigatedToHome = true // Cambiar la bandera
        }
        
        emailTextField.text = email
        passwordTextField.text = password
    }

    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Por favor completa todos los campos")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
                return
            }
            
            // Navegar a la pantalla principal después de un inicio de sesión exitoso
            strongSelf.navigateToHome(withEmail: email)
        }
    }
    
    private func navigateToHome(withEmail email: String) {
        print("Navegando a HomeViewController con email: \(email)")
        performSegue(withIdentifier: "goToHomeScreen", sender: email)
    }
    
    @IBAction func goToRegisterScreenButton(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterScreen", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

