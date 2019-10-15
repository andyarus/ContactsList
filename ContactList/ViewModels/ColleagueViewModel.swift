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
    return Format.shared.format(phone: colleague.phone)
  }
  
  var workPhone: String {
    return Format.shared.format(workPhone: colleague.workPhone)
  }
  
  var position: String {
    return colleague.position
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
                                position: position)
      
      colleagues.append(ColleagueViewModel(colleague: colleague))
    }
    
    colleagues.sort(by: <)
    
    return colleagues
  }
  
}

// MARK: - Configure

extension ColleagueViewModel {
  
  func configure(_ cell: ContactCell) {
    cell.photoImageView.image = photo
    
    var fullName = firstName
    if let middleName = middleName, !middleName.isEmpty {
      fullName.append(" \(middleName)")
    }
    fullName.append(" \(lastName)")
    
    cell.nameLabel.text = fullName
    cell.phoneLabel.text = phone
    cell.workPhoneLabel.text = workPhone
    cell.infoLabel.text = position
  }
  
}

// MARK: - Comparable

extension ColleagueViewModel: Comparable {
  
  static func == (lhs: ColleagueViewModel, rhs: ColleagueViewModel) -> Bool {
    return lhs.firstName == rhs.firstName &&
      lhs.lastName == rhs.lastName &&
      lhs.middleName == rhs.middleName &&
      lhs.photo == rhs.photo &&
      lhs.phone == rhs.phone &&
      lhs.workPhone == rhs.workPhone &&
      lhs.position == rhs.position
  }
  
  static func < (lhs: ColleagueViewModel, rhs: ColleagueViewModel) -> Bool {
    return lhs.firstName != rhs.firstName ? lhs.firstName < rhs.firstName :
      lhs.lastName != rhs.lastName ? lhs.lastName < rhs.lastName : lhs.middleName ?? "" < rhs.middleName ?? ""
  }
  
}
