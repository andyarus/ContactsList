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
  private(set) var colleague: Colleague
  
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
  
  var photo: UIImage? {
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
  
  var key: String {
    get {
      return colleague.key
    }
    set {
      colleague.key = newValue
    }
  }
  
  static func colleagues() -> [ColleagueViewModel] {
    var colleagues = [ColleagueViewModel]()
    
    //DatabaseService.shared.deleteData(all: .colleague(nil))
    
    let entities = DatabaseService.shared.retrieveData(all: .colleague(nil))
    for entity in entities {
      switch entity {
      case .colleague(let data):
        guard let data = data else { continue }

        let colleague = Colleague(firstName: data.firstName,
                                  lastName: data.lastName,
                                  middleName: data.middleName,
                                  photo: data.photo,
                                  phone: data.phone,
                                  workPhone: data.workPhone,
                                  position: data.position,
                                  key: data.phone)

        colleagues.append(ColleagueViewModel(colleague: colleague))
      default:
        break
      }
    }
    
    if colleagues.isEmpty {
      colleagues = defaultColleagues()
    }

    colleagues.sort(by: <)
    
    return colleagues
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
        let photoName = dictionary["Photo"],
        let phone = dictionary["Phone"],
        let workPhone = dictionary["WorkPhone"],
        let position = dictionary["Position"] else {
          continue
      }
      
      let colleague = Colleague(firstName: firstName,
                                lastName: lastName,
                                middleName: middleName,
                                photo: !photoName.isEmpty ? UIImage(named: photoName) : nil,
                                phone: phone,
                                workPhone: workPhone,
                                position: position,
                                key: phone)
      
      colleagues.append(ColleagueViewModel(colleague: colleague))
      
      // write to storage
      DatabaseService.shared.createData(for: .colleague(colleague))
    }
    
    return colleagues
  }
  
}

// MARK: - Configure

extension ColleagueViewModel {
  
  func configure(_ cell: ContactCell) {
    cell.photoImageView.image = photo ?? .defaultPhoto
    
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
