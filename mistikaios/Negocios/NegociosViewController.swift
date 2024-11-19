//
//  NegociosViewController.swift
//  mistikaios
//
//  Created by Deivid Jhon Del Carpio Vilca on 18/11/24.
//

import UIKit

class NegociosViewController: UIViewController {
    
    @IBOutlet weak var tbl_negocios: UITableView!
    @IBOutlet weak var tlb_negociosHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbl_negocios.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tbl_negocios.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tbl_negocios.removeObserver(self, forKeyPath: "contentSize")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
                if let newvalue = change?[.newKey] {
                    let newsize = newvalue as! CGSize
                    self.tlb_negociosHeight.constant = newsize.height
                }
        }
    }
}

extension NegociosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NegocioCell", for: indexPath) as? NegocioCell {
            cell.lbl_negocioTitle.text = "Negocio \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
