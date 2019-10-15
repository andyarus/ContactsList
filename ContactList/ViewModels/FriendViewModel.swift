//
//  FriendViewModel.swift
//  ContactList
//
//  Created by Andrei Coder on 13/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation
import UIKit

struct FriendViewModel {
  private let friend: Friend
  
  init(friend: Friend) {
    self.friend = friend
  }
  
  var firstName: String {
    return friend.firstName
  }
  
  var lastName: String {
    return friend.lastName
  }
  
  var middleName: String? {
    return friend.middleName
  }
  
  var photo: UIImage {
    return friend.photo
  }
  
  var phone: String {
    return Format.shared.format(phone: friend.phone)
  }
  
  var birthday: String {
    return Format.shared.format(toString: friend.birthday)
  }
  
  static func defaultFriends() -> [FriendViewModel] {
    var friends = [FriendViewModel]()
    
    guard let URL = Bundle.main.url(forResource: "DefaultFriends", withExtension: "plist"),
      let dictionaries = NSArray(contentsOf: URL) as? [[String: String]] else {
        return friends
    }
    for dictionary in dictionaries {
      guard let firstName = dictionary["FirstName"],
        let lastName = dictionary["LastName"],
        let middleName = dictionary["MiddleName"],
        let photoName = dictionary["Photo"], let photo = UIImage(named: photoName),
        let phone = dictionary["Phone"],
        let birthdayString = dictionary["Birthday"], let birthday = Format.shared.format(toDate: birthdayString) else {
          continue
      }
      
      let friend = Friend(firstName: firstName,
                             lastName: lastName,
                             middleName: middleName,
                             photo: photo,
                             phone: phone,
                             birthday: birthday)
      
      friends.append(FriendViewModel(friend: friend))
    }
    
    friends.sort(by: <)
    
    return friends
  }
  
}

// MARK: - Configure

extension FriendViewModel {
  
  func configure(_ cell: ContactCell) {
    cell.photoImageView.image = photo
    
    var fullName = firstName
    if let middleName = middleName, !middleName.isEmpty {
      fullName.append(" \(middleName)")
    }
    fullName.append(" \(lastName)")
    
    cell.nameLabel.text = fullName
    cell.phoneLabel.text = phone
    cell.infoLabel.text = birthday
  }
  
}

// MARK: - Comparable

extension FriendViewModel: Comparable {
  
  static func == (lhs: FriendViewModel, rhs: FriendViewModel) -> Bool {
    return lhs.firstName == rhs.firstName &&
      lhs.lastName == rhs.lastName &&
      lhs.middleName == rhs.middleName &&
      lhs.photo == rhs.photo &&
      lhs.phone == rhs.phone &&
      lhs.birthday == rhs.birthday
  }
  
  static func < (lhs: FriendViewModel, rhs: FriendViewModel) -> Bool {
    return lhs.firstName != rhs.firstName ? lhs.firstName < rhs.firstName :
      lhs.lastName != rhs.lastName ? lhs.lastName < rhs.lastName : lhs.middleName ?? "" < rhs.middleName ?? ""
  }
  
}
