//
//  Entity.swift
//  ContactList
//
//  Created by Andrei Coder on 17/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

enum Entity {
  case colleague(Colleague?)
  case friend(Friend?)
  
  func name() -> String {
    switch self {
    case .colleague:
      return "ColleagueEntity"
    case .friend:
      return "FriendEntity"
    }
  }
  
}
