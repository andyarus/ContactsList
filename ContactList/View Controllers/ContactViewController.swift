//
//  ContactViewController.swift
//  ContactList
//
//  Created by Andrei Coder on 14/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

  // MARK: - Properties
  
  var contact: ContactViewModel?
  var idx: Int?
  
  let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 23.0
    
    return imageView
  }()
  
  let firstNameTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Имя"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()

  let lastNameTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Фамилия"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()

  let middleNameTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Отчество"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()

  let phoneTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Телефон"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()

  let workPhoneTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Рабочий телефон"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()
  
  let positionTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Должность"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0
    
    return textField
  }()
  
  let birthdayTextField: TextField = {
    let textField = TextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Дата рождения"
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.cornerRadius = 4.0

    return textField
  }()
  
  let saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Сохранить", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    
    return button
  }()

  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  // MARK: - Setup Methods
  
  func setup() {
    view.backgroundColor = .white
    
    addSubviews()
    setupConstraints()
    
    saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped)))
    
    contact?.configure(self)
  }
  
  func addSubviews() {
    view.addSubview(photoImageView)
    view.addSubview(firstNameTextField)
    view.addSubview(lastNameTextField)
    view.addSubview(middleNameTextField)
    view.addSubview(phoneTextField)
    view.addSubview(workPhoneTextField)
    view.addSubview(positionTextField)
    view.addSubview(birthdayTextField)
    view.addSubview(saveButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 146.0),
      photoImageView.heightAnchor.constraint(equalToConstant: 146.0),
      photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
      photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      firstNameTextField.heightAnchor.constraint(equalToConstant: 30.0),
      firstNameTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20.0),
      firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      lastNameTextField.heightAnchor.constraint(equalToConstant: 30.0),
      lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10.0),
      lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      middleNameTextField.heightAnchor.constraint(equalToConstant: 30.0),
      middleNameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10.0),
      middleNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      middleNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      phoneTextField.heightAnchor.constraint(equalToConstant: 30.0),
      phoneTextField.topAnchor.constraint(equalTo: middleNameTextField.bottomAnchor, constant: 10.0),
      phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      workPhoneTextField.heightAnchor.constraint(equalToConstant: 30.0),
      workPhoneTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10.0),
      workPhoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      workPhoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      positionTextField.heightAnchor.constraint(equalToConstant: 30.0),
      positionTextField.topAnchor.constraint(equalTo: workPhoneTextField.bottomAnchor, constant: 10.0),
      positionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      positionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      birthdayTextField.heightAnchor.constraint(equalToConstant: 30.0),
      //birthdayTextField.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 10.0),
      birthdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
      birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
      
      saveButton.widthAnchor.constraint(equalToConstant: 100.0),
      saveButton.heightAnchor.constraint(equalToConstant: 40.0),
      //saveButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0),
      saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
  }
  
  func setupColleagueConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 10.0),
      saveButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 30.0)
      ])
  }
  
  func setupFriendConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10.0),
      saveButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0)
      ])
  }
  
  // MARK: - Tap Methods
  
  @objc
  func saveButtonTapped() {
    guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
      AlertUtils.shared.error(in: self, message: "Имя не может быть пустым!")
      return
    }
    
    guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
      AlertUtils.shared.error(in: self, message: "Фамилия не может быть пустой!")
      return
    }
    
    let middleName = middleNameTextField.text
    
    guard let phone = phoneTextField.text, !phone.isEmpty else {
      AlertUtils.shared.error(in: self, message: "Телефон не может быть пустой!")
      return
    }
    
    guard let photo = photoImageView.image else {
      AlertUtils.shared.error(in: self, message: "Что-то пошло не так")
      return
    }
    
    guard let vc = navigationController?.viewControllers.first as? ContactsViewController,
      let idx = idx,
      let relation = contact?.relation else {
        AlertUtils.shared.error(in: self, message: "Что-то пошло не так")
        return
      }
    
    let updatedRelation: Relation
    switch relation {
    case .colleague:
      guard let workPhone = workPhoneTextField.text, !workPhone.isEmpty else {
        AlertUtils.shared.error(in: self, message: "Рабочий телефон не может быть пустой!")
        return
      }
      guard let position = positionTextField.text, !position.isEmpty else {
        AlertUtils.shared.error(in: self, message: "Должность не может быть пустой!")
        return
      }
      
      let colleague = Colleague(firstName: firstName,
                                lastName: lastName,
                                middleName: middleName,
                                photo: photo,
                                phone: phone,
                                workPhone: workPhone,
                                position: position)
      
      updatedRelation = .colleague(ColleagueViewModel(colleague: colleague))
    case .friend:
      guard let birthdayString = birthdayTextField.text, let birthday = FormatUtils.shared.format(toDate: birthdayString) else {
        AlertUtils.shared.error(in: self, message: "Неверный формат даты рождения! Формат должен быть таким:\(FormatUtils.shared.format(toString: Date())) (день.месяц.год)")
        return
      }
      
      let friend = Friend(firstName: firstName,
                                lastName: lastName,
                                middleName: middleName,
                                photo: photo,
                                phone: phone,
                                birthday: birthday)
      
      updatedRelation = .friend(FriendViewModel(friend: friend))
    }
    let updatedContact = ContactViewModel(contact: Contact(relation: updatedRelation))

    vc.updateContact(updatedContact, in: idx)
    
    navigationController?.popViewController(animated: true)
  }
  
}