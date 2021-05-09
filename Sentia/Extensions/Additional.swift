//
//  Additional.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation
import UIKit

 
class Alert {
class func show(title: String, message: String, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert, animated: true)
    }
}

struct AppIsIn {
    static var Foreground = Bool()
}
 
