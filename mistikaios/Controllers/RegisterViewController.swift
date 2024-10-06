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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logoImageView.image = UIImage(named: "logo")


    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            print("Por favor completa todos los campos.")
            return
        }
        
        // Validar la contraseña
        if password != confirmPassword {
            print("Las contraseñas no coinciden.")
            return
        }
        
        if password.count < 6 {
            print("La contraseña debe tener al menos 4 caracteres.")
            return
        }
        
        // Crear un nuevo usuario en Firebase
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error al crear el usuario: \(error.localizedDescription)")
                return
            }
            
            // Si la cuenta se creó con éxito, puedes obtener el usuario
            guard let user = authResult?.user else { return }
            print("Usuario registrado: \(user.uid)")
            
            // Aquí puedes guardar información adicional del usuario, como el nombre
            // en la base de datos de Firestore si lo deseas.
            
            // Navegar a la siguiente pantalla o mostrar un mensaje de éxito
            self.performSegue(withIdentifier: "homeScreen", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    
    @IBAction func goToLoginButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
}
