//
//  Contacts.swift
//  ContactList
//
//  Created by Andrei Coder on 18/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

struct Contacts {
  public var colleagues = ColleagueViewModel.colleagues()
  public var friends = FriendViewModel.friends()
  
  // write contact to storage
  func add(_ contact: Contact) {
    switch contact {
    case .colleague(let colleagueViewModel):
      guard let colleagueViewModel = colleagueViewModel else { return }
      DatabaseService.shared.createData(for: .colleague(colleagueViewModel.colleague))
    case .friend(let friendViewModel):
      guard let friendViewModel = friendViewModel else { return }
      DatabaseService.shared.createData(for: .friend(friendViewModel.friend))
    }
  }
  
  // update contact in storage
  func update(_ contact: Contact) {
    switch contact {
    case .colleague(let colleagueViewModel):
      guard let colleagueViewModel = colleagueViewModel else { return }
      DatabaseService.shared.updateData(by: colleagueViewModel.colleague.key, with: .colleague(colleagueViewModel.colleague))
    case .friend(let friendViewModel):
      guard let friendViewModel = friendViewModel else { return }
      DatabaseService.shared.updateData(by: friendViewModel.friend.key, with: .friend(friendViewModel.friend))
    }
  }
  
  // remove contact from storage
  func delete(_ contact: Contact) {
    switch contact {
    case .colleague(let colleagueViewModel):
      guard let colleagueViewModel = colleagueViewModel else { return }
      DatabaseService.shared.deleteData(by: colleagueViewModel.colleague.key, for: .colleague(colleagueViewModel.colleague))
    case .friend(let friendViewModel):
      guard let friendViewModel = friendViewModel else { return }
      DatabaseService.shared.deleteData(by: friendViewModel.friend.key, for: .friend(friendViewModel.friend))
    }
  }

}
