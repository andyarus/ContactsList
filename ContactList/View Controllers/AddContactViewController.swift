//
//  AddContactViewController.swift
//  ContactList
//
//  Created by Andrei Coder on 15/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
  
  // MARK: - Properties
  
  var relation: Relation?
  var imagePicker = UIImagePickerController()
  
  // MARK: - Keyboard Show/Hide Handling
  
  var originY: CGFloat?
  var touchLocation: CGPoint?
  var textFieldHeight: CGFloat = 0.0
  var keyboardHeight: CGFloat = 0.0
  var keyboardShown: Bool = false
  var topmostTextField: UITextField?
  
  // MARK: - Subviews
  
  let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 23.0
    imageView.image = UIImage(named: "profilePlaceholder")    
    return imageView
  }()
  
  let changePhotoButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Добавить фото", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 10)
    
    return button
  }()
  
  let firstNameTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Имя"
    return textField
  }()
  
  let lastNameTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Фамилия"
    return textField
  }()
  
  let middleNameTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Отчество"
    return textField
  }()
  
  let phoneTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Телефон"
    textField.keyboardType = .phonePad
    return textField
  }()
  
  let workPhoneTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Рабочий телефон"
    textField.keyboardType = .phonePad
    return textField
  }()
  
  let positionTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Должность"
    return textField
  }()
  
  let birthdayTextField: TextField = {
    let textField = TextField()
    textField.placeholder = "Дата рождения"
    return textField
  }()
  
  let addButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Добавить", for: .normal)
    button.setTitleColor(.blue, for: .normal)    
    return button
  }()
  
  // MARK: - Deinitializer
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  // MARK: - Keyboard Show/Hide
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  @objc
  func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      if originY == nil {
        originY = view.frame.origin.y
      }
      if let touchLocation = touchLocation, view.frame.height - touchLocation.y - textFieldHeight < keyboardSize.height, view.frame.origin.y == originY {
        view.frame.origin.y -= keyboardSize.height - (view.frame.height - touchLocation.y) + textFieldHeight
      }
      keyboardHeight = keyboardSize.height
    }
    keyboardShown = true
  }
  
  @objc
  func keyboardWillHide(notification: NSNotification) {
    if keyboardShown {
      view.frame.origin.y = originY ?? 0.0
    }
    keyboardShown = false
  }
  
  // MARK: - TextField Tap Gesture Recognize Methods
  
  @objc
  func firstNameTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = firstNameTextField.frame.height
    firstNameTextField.becomeFirstResponder()
  }
  
  @objc
  func lastNameTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = lastNameTextField.frame.height
    lastNameTextField.becomeFirstResponder()
  }
  
  @objc
  func middleNameTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = middleNameTextField.frame.height
    middleNameTextField.becomeFirstResponder()
  }
  
  @objc
  func phoneTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = phoneTextField.frame.height
    phoneTextField.becomeFirstResponder()
  }
  
  @objc
  func workPhoneTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = workPhoneTextField.frame.height
    workPhoneTextField.becomeFirstResponder()
  }
  
  @objc
  func positionTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = positionTextField.frame.height
    positionTextField.becomeFirstResponder()
  }
  
  @objc
  func birthdayTextFieldTapped(gr: UITapGestureRecognizer) {
    touchLocation = gr.location(in: view)
    textFieldHeight = birthdayTextField.frame.height
    birthdayTextField.becomeFirstResponder()
  }
  
  // MARK: - Setup Methods
  
  func setup() {
    setupUI()
    setupKeyboardHandling()
    setupImagePickerController()
  }
  
  func setupUI() {
    view.backgroundColor = .white
    
    addSubviews()
    setupGestureRecognizers()
    setupConstraints()
    setupTextFields()
  }
  
  func addSubviews() {
    view.addSubview(photoImageView)
    view.addSubview(changePhotoButton)
    view.addSubview(firstNameTextField)
    view.addSubview(lastNameTextField)
    view.addSubview(middleNameTextField)
    view.addSubview(phoneTextField)
    view.addSubview(workPhoneTextField)
    view.addSubview(positionTextField)
    view.addSubview(birthdayTextField)
    view.addSubview(addButton)
  }
  
  func setupGestureRecognizers() {
    photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePhotoButtonTapped)))
    changePhotoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePhotoButtonTapped)))
    addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addButtonTapped)))
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 146.0),
      photoImageView.heightAnchor.constraint(equalToConstant: 146.0),
      photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0),
      photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      changePhotoButton.widthAnchor.constraint(equalToConstant: 100.0),
      changePhotoButton.heightAnchor.constraint(equalToConstant: 30.0),
      changePhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0.0),
      changePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      firstNameTextField.heightAnchor.constraint(equalToConstant: 30.0),
      firstNameTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30.0),
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
      
      addButton.widthAnchor.constraint(equalToConstant: 100.0),
      addButton.heightAnchor.constraint(equalToConstant: 40.0),
      //addButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0),
      addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
    
    guard let relation = relation else { return }
    switch relation {
    case .colleague:
      workPhoneTextField.isHidden = false
      positionTextField.isHidden = false
      birthdayTextField.isHidden = true
      
      setupColleagueConstraints()
    case .friend:
      workPhoneTextField.isHidden = true
      positionTextField.isHidden = true
      birthdayTextField.isHidden = false
      
      setupFriendConstraints()
    }
  }
  
  func setupColleagueConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 10.0),
      addButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 30.0)
      ])
  }
  
  func setupFriendConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10.0),
      addButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0)
      ])
  }
  
  func setupTextFields() {
    firstNameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstNameTextFieldTapped)))
    lastNameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lastNameTextFieldTapped)))
    middleNameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(middleNameTextFieldTapped)))
    phoneTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneTextFieldTapped)))
    workPhoneTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(workPhoneTextFieldTapped)))
    positionTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(positionTextFieldTapped)))
    birthdayTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(birthdayTextFieldTapped)))
    
    firstNameTextField.delegate = self
    lastNameTextField.delegate = self
    middleNameTextField.delegate = self
    phoneTextField.delegate = self
    workPhoneTextField.delegate = self
    positionTextField.delegate = self
    birthdayTextField.delegate = self
    
    topmostTextField = firstNameTextField
  }
  
  func setupKeyboardHandling() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func setupImagePickerController() {
    //imagePicker.modalPresentationStyle = .fullScreen // in ios 13 default presentation is page sheet
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
  }
  
  // MARK: - Actions
  
  @objc
  func changePhotoButtonTapped() {
    present(imagePicker, animated: true, completion: nil)
  }
  
  @objc
  func addButtonTapped() {
    // firstName validation
    guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty else {
      Alert.shared.error(in: self, message: "Имя не может быть пустым!")
      return
    }
    guard Validator.shared.isValid(name: firstName) else {
      Alert.shared.error(in: self, message: "Неверный формат имени! Разрешены только буквы.")
      return
    }
    
    // lastName validation
    guard let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty else {
      Alert.shared.error(in: self, message: "Фамилия не может быть пустой!")
      return
    }
    guard Validator.shared.isValid(name: lastName) else {
      Alert.shared.error(in: self, message: "Неверный формат фамилии! Разрешены только буквы.")
      return
    }
    
    // middleName validation
    guard let middleName = middleNameTextField.text?.trimmingCharacters(in: .whitespaces) else {
      Alert.shared.error(in: self, message: "Что-то пошло не так")
      return
    }
    guard Validator.shared.isValid(middleName: middleName) else {
      Alert.shared.error(in: self, message: "Неверный формат отчества! Разрешены только буквы.")
      return
    }
    
    guard let phone = phoneTextField.text?.trimmingCharacters(in: .whitespaces), !phone.isEmpty else {
      Alert.shared.error(in: self, message: "Телефон не может быть пустой!")
      return
    }
    guard Validator.shared.isValid(phone: phone) else {
      Alert.shared.error(in: self, message: "Неверный формат телефона! Разрешены только номера до 11 цифр.")
      return
    }
    
    guard let photo = photoImageView.image else {
      Alert.shared.error(in: self, message: "Что-то пошло не так")
      return
    }
    
    guard let vc = navigationController?.viewControllers.first as? ContactsViewController,
      let relation = relation else {
        Alert.shared.error(in: self, message: "Что-то пошло не так")
        return
    }

    let updatedRelation: Relation
    switch relation {
    case .colleague:
      guard let workPhone = workPhoneTextField.text?.trimmingCharacters(in: .whitespaces), !workPhone.isEmpty else {
        Alert.shared.error(in: self, message: "Рабочий телефон не может быть пустой!")
        return
      }
      guard Validator.shared.isValid(phone: workPhone) else {
        Alert.shared.error(in: self, message: "Неверный формат телефона! Разрешены только номера до 11 цифр.")
        return
      }
      
      guard let position = positionTextField.text?.trimmingCharacters(in: .whitespaces), !position.isEmpty else {
        Alert.shared.error(in: self, message: "Должность не может быть пустой!")
        return
      }
      guard Validator.shared.isValid(position: position) else {
        Alert.shared.error(in: self, message: "Неверный формат должности!")
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
      guard let birthdayString = birthdayTextField.text?.trimmingCharacters(in: .whitespaces), let birthday = Format.shared.format(toDate: birthdayString) else {
        Alert.shared.error(in: self, message: "Неверный формат даты рождения! Формат должен быть таким:\(Format.shared.format(toString: Date())) (день.месяц.год)")
        return
      }
      guard Validator.shared.isValid(birthday: birthday) else {
        Alert.shared.error(in: self, message: "Неверная дата рождения!")
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
    
    vc.addContact(updatedContact)
    
    navigationController?.popViewController(animated: true)
  }
  
}

// MARK: - UITextFieldDelegate

extension AddContactViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    // process on filled
    if let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty,
      let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty,
      let _ = middleNameTextField.text?.trimmingCharacters(in: .whitespaces),
      let phone = phoneTextField.text?.trimmingCharacters(in: .whitespaces), !phone.isEmpty,
      let relation = relation {
      var fillDone = false
      switch relation {
      case .colleague:
        if let workPhone = workPhoneTextField.text?.trimmingCharacters(in: .whitespaces), !workPhone.isEmpty,
        let position = positionTextField.text?.trimmingCharacters(in: .whitespaces), !position.isEmpty {
          fillDone = true
        }
      case .friend:
        if let birthdayString = birthdayTextField.text?.trimmingCharacters(in: .whitespaces), !birthdayString.isEmpty {
          fillDone = true
        }
      }
      if fillDone {
        addButtonTapped()
        return false
      }
    }
    
    switch textField {
    case firstNameTextField:
      lastNameTextField.becomeFirstResponder()
    case lastNameTextField:
      middleNameTextField.becomeFirstResponder()
    case middleNameTextField:
      phoneTextField.becomeFirstResponder()
    case phoneTextField:
      guard let relation = relation else { return false }
      switch relation {
      case .colleague:
        workPhoneTextField.becomeFirstResponder()
      case .friend:
        birthdayTextField.becomeFirstResponder()
      }
    case workPhoneTextField:
      positionTextField.becomeFirstResponder()
    case positionTextField:
      firstNameTextField.becomeFirstResponder()
    case birthdayTextField:
      firstNameTextField.becomeFirstResponder()
    default:
      textField.resignFirstResponder()
    }
    
    keyboardReturnPressed(in: textField, isLastTextField: (textField == positionTextField || textField == birthdayTextField))
    
    return false
  }
  
  // make visible textField by changing view.frame.origin.y
  func keyboardReturnPressed(in textField: UITextField, isLastTextField: Bool) {
    guard let lastTouchLocation = touchLocation, let originY = originY else { return }
    if isLastTextField, let topmostTextField = topmostTextField {
      // the topmost textField
      touchLocation = CGPoint(x: lastTouchLocation.x, y: topmostTextField.frame.minY + textFieldHeight/2)
      if view.frame.origin.y != originY {
        view.frame.origin.y = originY
      }
    } else {
      // the next textField. 10 - space between textFields
      touchLocation = CGPoint(x: lastTouchLocation.x, y: lastTouchLocation.y + textFieldHeight + 10)
    }
    
    // check whether the keyboard will hide textField
    if let touchLocation = touchLocation, view.frame.height - touchLocation.y - textFieldHeight < keyboardHeight {
      view.frame.origin.y = originY - (keyboardHeight - (view.frame.height - touchLocation.y) + textFieldHeight)
    }
  }
  
}

// MARK: - UIImagePickerControllerDelegate

extension EditContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      photoImageView.image = image
    }
    
    picker.dismiss(animated: true)
  }

}
