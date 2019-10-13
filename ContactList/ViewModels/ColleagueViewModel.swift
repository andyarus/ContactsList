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
    return FormatUtils.shared.format(phone: colleague.phone)
  }
  
  var workPhone: String {
    return FormatUtils.shared.format(workPhone: colleague.workPhone)
  }
  
  var positin: String {
    return colleague.positin
  }
  
  static func defaultColleagues() -> [ColleagueViewModel] {
    var colleagues = [ColleagueViewModel]()
    
    guard let URL = Bundle.main.url(forResource: "DefaultColleagues", withExtension: "plist"),
      let dictionaries = NSArray(contentsOf: URL) as? [[String: String]] else {
        return colleagues
    }
    for dictionary in dictionaries {
      guard let firstName = dictionary["FirstName"],
        let lastName = dictionary["LastName"],
        let middleName = dictionary["MiddleName"],
        let photoName = dictionary["Photo"], let photo = UIImage(named: photoName),
        let phone = dictionary["Phone"],
        let workPhone = dictionary["WorkPhone"],
        let position = dictionary["Position"] else {
          continue
      }
      
      let colleague = Colleague(firstName: firstName,
                                lastName: lastName,
                                middleName: middleName,
                                photo: photo,
                                phone: phone,
                                workPhone: workPhone,
                                positin: position)
      
      colleagues.append(ColleagueViewModel(colleague: colleague))
    }
    
    return colleagues
  }
  
}

extension ColleagueViewModel {
  
  func configure(_ cell: ContactCell) {
    cell.photoImageView.image = photo
    cell.nameLabel.text = "\(lastName) \(firstName) \(middleName ?? "")"
    cell.phoneLabel.text = phone
    cell.workPhoneLabel.text = workPhone
    cell.infoLabel.text = positin
  }
  
}
