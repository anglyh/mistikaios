//
//  RegisterViewController.swift
//  mistikaios
//
//  Created by angel on 5/10/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var emailToPass: String?
    var passwordToPass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            AlertManager.showErrorAlert(from: self, message: "Por favor completa todos los campos.")
            return
        }
        
        // Validar la contraseña
        if password != confirmPassword {
            AlertManager.showErrorAlert(from: self, message: "Las contraseñas no coinciden.")
            return
        }
        
        if password.count < 6 {
            AlertManager.showErrorAlert(from: self, message: "La contraseña debe tener al menos 6 caracteres.")
            return
        }
        
        // Crear un nuevo usuario en Firebase
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                AlertManager.showErrorAlert(from: strongSelf, message: "Se ha producido un error al registrar el usuario: \(error.localizedDescription)")
                return
            }
            
            // Si la cuenta se creó con éxito, obtener el usuario
            guard let user = authResult?.user else { return }
            print("Usuario registrado: \(user.uid)")
            
            self?.emailToPass = email
            self?.passwordToPass = password
            
            // Mostrar alerta de éxito
            AlertManager.showSuccessAlert(from: strongSelf, message: "Usuario creado con éxito.") {
                // Regresar a LoginViewController
                strongSelf.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func goToLoginButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginVC = segue.destination as? LoginViewController {
            loginVC.email = emailToPass
            loginVC.password = passwordToPass
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
