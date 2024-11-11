//
//  EventosViewController.swift
//  mistikaios
//
//  Created by Deivid Del Carpio on 8/11/24.
//

import UIKit

class EventosViewController: UIViewController {

    @IBOutlet weak var tbl_events: UITableView!
    @IBOutlet weak var tlb_eventsHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbl_events.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tbl_events.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tbl_events.removeObserver(self, forKeyPath: "contentSize")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
                if let newvalue = change?[.newKey] {
                    let newsize = newvalue as! CGSize
                    self.tlb_eventsHeight.constant = newsize.height
                }
        }
    }


}
extension EventosViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
            cell.lbl_eventTitle.text = "Evento \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
}
