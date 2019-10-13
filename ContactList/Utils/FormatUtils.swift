//
//  FormatUtils.swift
//  ContactList
//
//  Created by Andrei Coder on 13/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

class FormatUtils {
  
  static let shared = FormatUtils()
  
  let dateFormatter = DateFormatter()
  
  init() {
    dateFormatter.dateFormat = "dd.MM.yyyy"
  }
  
  func format(phone: String) -> String {
    var phone = phone
    if phone.starts(with: "8") {
      phone = "тел: +7\(phone.dropFirst())"
    }
    
    return phone
  }
  
  func format(workPhone: String) -> String {
    return "раб.тел: \(workPhone)"
  }
  
  func format(toDate birthday: String) -> Date? {
    return dateFormatter.date(from: birthday)
  }
  
  func format(toString birthday: Date) -> String {
    return dateFormatter.string(from: birthday)
  }
  
}
