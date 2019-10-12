//
//  ColleagueViewModel.swift
//  ContactList
//
//  Created by Andrei Coder on 13/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation
import UIKit

struct ColleagueViewModel {
  private let colleague: Colleague
  
  init(colleague: Colleague) {
    self.colleague = colleague
  }
  
  var firstName: String {
    return colleague.firstName
  }
  
  var lastName: String {
    return colleague.lastName
  }
  
  var middleName: String? {
    return colleague.middleName
  }
  
  var photo: UIImage {
    return colleague.photo
  }
  
  var phone: String {
    return colleague.phone
  }
  
  var workPhone: String {
    return colleague.workPhone
  }
  
  var positin: String {
    return colleague.positin
  }
}
