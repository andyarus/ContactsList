//
//  Validator.swift
//  ContactList
//
//  Created by Andrei Coder on 15/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

class Validator {
  
  static let shared = Validator()
  
  func isValid(name: String) -> Bool {
    return name.range(of: "^[a-zA-Zа-яА-Я]{1,50}$", options: .regularExpression) != nil
  }
  
  func isValid(middleName: String) -> Bool {
    return middleName.range(of: "^[a-zA-Zа-яА-Я]{0,50}$", options: .regularExpression) != nil
  }
  
  func isValid(names: [String]) -> Bool {
    for name in names {
      if !isValid(name: name) {
        return false
      }
    }
    
    return true
  }
  
  func isValid(phone: String) -> Bool {
    return phone.range(of: "^+?[0-9]{1,11}$", options: .regularExpression) != nil
  }
  
  func isValid(position: String) -> Bool {
    return position.range(of: "^.{1,50}$", options: .regularExpression) != nil
  }
  
  func isValid(birthday: Date) -> Bool {
    return birthday < Date()
  }
  
}
