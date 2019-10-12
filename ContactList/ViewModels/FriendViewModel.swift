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
    return friend.phone
  }
  
  var birthday: Date {
    return friend.birthday
  }
}
