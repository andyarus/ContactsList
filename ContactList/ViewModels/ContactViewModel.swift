//
//  ContactViewModel.swift
//  ContactList
//
//  Created by Andrei Coder on 14/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

struct ContactViewModel {
  private(set) var contact: Contact
  
  init(contact: Contact) {
    self.contact = contact
  }
}

extension ContactViewModel {
  
  func configure(_ vc: ContactViewController) {
    switch contact {
    case .colleague(let colleague):
      guard let colleague = colleague else { return }
      vc.photoImageView.image = colleague.photo ?? .defaultPhoto
      vc.firstNameTextField.text = colleague.firstName
      vc.lastNameTextField.text = colleague.lastName
      vc.middleNameTextField.text = colleague.middleName      
      vc.phoneTextField.text = Format.shared.clear(phone: colleague.phone)
      vc.workPhoneTextField.text = Format.shared.clear(workPhone: colleague.workPhone)
      vc.positionTextField.text = colleague.position
      
      vc.workPhoneTextField.isHidden = false
      vc.positionTextField.isHidden = false
      vc.birthdayTextField.isHidden = true
      
      vc.setupColleagueConstraints()
    case .friend(let friend):
      guard let friend = friend else { return }
      vc.photoImageView.image = friend.photo ?? .defaultPhoto
      vc.firstNameTextField.text = friend.firstName
      vc.lastNameTextField.text = friend.lastName
      vc.middleNameTextField.text = friend.middleName
      vc.phoneTextField.text = Format.shared.clear(phone: friend.phone)
      vc.birthdayTextField.text = friend.birthday
      
      vc.workPhoneTextField.isHidden = true
      vc.positionTextField.isHidden = true
      vc.birthdayTextField.isHidden = false
      
      vc.setupFriendConstraints()
    }
  }
  
}
