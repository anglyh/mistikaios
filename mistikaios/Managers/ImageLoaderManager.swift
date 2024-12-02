//
//  ImageLoaderManager.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 1/12/24.
//

import UIKit

class ImageLoader {
    
    // Función para cargar la imagen de una URL con manejo de errores
    static func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            // Si la URL no es válida, asignamos una imagen de placeholder
            imageView.image = UIImage(named: "placeholder")
            return
        }
        
        // Configuración común de la imagen
        imageView.contentMode = .scaleAspectFill  // Mantiene la proporción de la imagen
        imageView.layer.cornerRadius = 15         // Radio de esquina
        imageView.clipsToBounds = true            // Recorta la imagen para que no sobresalga
        
        // Realizamos la tarea de carga de la imagen en segundo plano
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Si hay un error o los datos no son válidos, asignamos la imagen de placeholder
            if let error = error {
                print("Error al cargar la imagen: \(error)")
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            // Si los datos se reciben correctamente, asignamos la imagen
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "placeholder")
                }
            }
        }.resume()
    }
}
