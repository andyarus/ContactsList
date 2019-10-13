//
//  ContactViewModel.swift
//  ContactList
//
//  Created by Andrei Coder on 14/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

struct ContactViewModel {
  private let contact: Contact
  
  init(contact: Contact) {
    self.contact = contact
  }
  
  var relation: Relation {
    return contact.relation
  }
}

extension ContactViewModel {
  
  func configure(_ vc: ContactViewController) {
    switch contact.relation {
    case .colleague(let colleague):
      vc.photoImageView.image = colleague.photo
      vc.firstNameTextField.text = colleague.firstName
      vc.lastNameTextField.text = colleague.lastName
      vc.middleNameTextField.text = colleague.middleName      
      vc.phoneTextField.text = FormatUtils.shared.clear(phone: colleague.phone)
      vc.workPhoneTextField.text = FormatUtils.shared.clear(workPhone: colleague.workPhone)
      vc.positionTextField.text = colleague.position
      
      vc.workPhoneTextField.isHidden = false
      vc.positionTextField.isHidden = false
      vc.birthdayTextField.isHidden = true
      
      vc.setupColleagueConstraints()
    case .friend(let friend):
      vc.photoImageView.image = friend.photo
      vc.firstNameTextField.text = friend.firstName
      vc.lastNameTextField.text = friend.lastName
      vc.middleNameTextField.text = friend.middleName
      vc.phoneTextField.text = FormatUtils.shared.clear(phone: friend.phone)
      vc.birthdayTextField.text = friend.birthday
      
      vc.workPhoneTextField.isHidden = true
      vc.positionTextField.isHidden = true
      vc.birthdayTextField.isHidden = false
      
      vc.setupFriendConstraints()
    }
  }
  
}
