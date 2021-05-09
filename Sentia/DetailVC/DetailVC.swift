//
//  DetailVC.swift
//  Sentia
//
//  Created by Matthew on 9/5/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = id
    }
    @IBAction func cancelCity(_ sender: Any) {
        dismiss(animated: true) {
        }
    }
}
