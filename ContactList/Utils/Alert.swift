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
  
  private init() { }
  
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
  
  func changePhoto(in vc: UIViewController, message: String? = nil, title: String? = nil, completion: @escaping (AlertChangePhoto) -> Void) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    alertController.popoverPresentationController?.sourceView = vc.view  // if not set it will crash on iPad
    if UIDevice.isIPad {
      alertController.popoverPresentationController?.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.maxY - 100, width: 0, height: 0)
      alertController.popoverPresentationController?.permittedArrowDirections = []
    }    
    
    let changeAction = UIAlertAction(title: "Изменить", style: .default) { _ in
      completion(.change)
    }
    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
      completion(.delete)
    }
    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
    
    alertController.addAction(changeAction)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    
    vc.present(alertController, animated: true, completion: nil)
  }
  
}
