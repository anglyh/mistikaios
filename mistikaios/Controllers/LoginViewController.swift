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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        logoImageView.image = UIImage(named: "logo")

        
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
            
            // Si el inicio de sesión es exitoso
            print("Inicio de sesión exitoso: \(authResult?.user.uid ?? "")")
            
            // Aquí puedes navegar a la siguiente pantalla
            // strongSelf.performSegue(withIdentifier: "homeScreen", sender: strongSelf)
        }
    }
    
    @IBAction func goToRegisterScreenButton(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterScreen", sender: self)
    }
    

    

}

