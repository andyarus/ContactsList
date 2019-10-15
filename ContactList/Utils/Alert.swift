//
//  Alert.swift
//  ContactList
//
//  Created by Andrei Coder on 14/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation
import UIKit

class Alert {
  
  static let shared = Alert()
  
  func error(in view: UIViewController, message: String, title: String? = "Ошибка") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    view.present(alert, animated: true, completion: nil)
  }
  
  func error(in view: UIViewController, message: String, title: String? = "Ошибка", completion: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion()
    }))
    view.present(alert, animated: true, completion: nil)
  }
  
}
