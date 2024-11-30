//
//  WebViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 28/11/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Crear la URL a cargar
        if let url = URL(string: "https://bozanilda.github.io/P-gina-legal-de-ParkAll/privacy-policy.html") {
            // Crear la solicitud de la URL
            let request = URLRequest(url: url)
            
            // Cargar la solicitud en el WKWebView
            webView.load(request)
        }
    }
}
