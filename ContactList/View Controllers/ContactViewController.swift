//
//  ContactViewController.swift
//  ContactList
//
//  Created by Andrei Coder on 16/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
  
  // MARK: - Properties
  
  open var role: ControllerRole?
  open var contactViewModel: ContactViewModel?
  open var idx: Int?
  
  private var datePicker = UIDatePicker()
  private var imagePicker = UIImagePickerController()
  
  // MARK: - Keyboard Show/Hide Handling
  
  private var originY: CGFloat?
  private var touchLocation: CGPoint?
  private var textFieldHeight: CGFloat = 0.0
  private var keyboardHeight: CGFloat = 0.0
  private var keyboardShown: Bool = false
  private var topmostTextField: UITextField?
  
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
  
  let changeContactButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
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
    
    guard let birthdayString = birthdayTextField.text?.trimmingCharacters(in: .whitespaces),
      let birthday = Format.shared.format(toDate: birthdayString),
      Validator.shared.isValid(birthday: birthday) else { return }
    
    datePicker.setDate(birthday, animated: true)
  }
  
  // MARK: - Setup Methods
  
  func setup() {
    setupUI()
    setupByRole()
    setupByRelation()
    setupKeyboardHandling()
    setupDatePicker()
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
    view.addSubview(changeContactButton)
  }
  
  func setupGestureRecognizers() {
    photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePhotoButtonTapped)))
    changePhotoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePhotoButtonTapped)))
    changeContactButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeContactButtonTapped)))
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 146.0),
      photoImageView.heightAnchor.constraint(equalToConstant: 146.0),
      photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 95.0),
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
      
      changeContactButton.widthAnchor.constraint(equalToConstant: 100.0),
      changeContactButton.heightAnchor.constraint(equalToConstant: 40.0),
      //changeContactButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0),
      changeContactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
  }
  
  func setupColleagueConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 10.0),
      changeContactButton.topAnchor.constraint(equalTo: positionTextField.bottomAnchor, constant: 30.0)
      ])
  }
  
  func setupFriendConstraints() {
    NSLayoutConstraint.activate([
      birthdayTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10.0),
      changeContactButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 30.0)
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
  
  func setupByRole() {
    guard let role = role else { return }
    switch role {
    case .edit:
      contactViewModel?.configure(self)
      
      if photoImageView.image == .defaultPhoto {
        changePhotoButton.setTitle("Добавить фото", for: .normal)
      } else {
        changePhotoButton.setTitle("Изменить фото", for: .normal)
      }
      changeContactButton.setTitle("Сохранить", for: .normal)
    case .add:
      changePhotoButton.setTitle("Добавить фото", for: .normal)
      changeContactButton.setTitle("Добавить", for: .normal)
    }
  }
  
  func setupByRelation() {
    guard let contact = contactViewModel?.contact else { return }
    switch contact {
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
  
  func setupKeyboardHandling() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func setupDatePicker() {
    datePicker.datePickerMode = .date
    datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -150, to: Date())
    datePicker.maximumDate = Date()
    if let isEmpty = birthdayTextField.text?.isEmpty, isEmpty,
      let date = Calendar.current.date(byAdding: .year, value: -20, to: Date()) {
      datePicker.setDate(date, animated: true)
    }
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(datePickerCancelButtonTapped))
    let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(datePickerDoneButtonTapped))
    let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    toolbar.setItems([cancelButton, space, doneButton], animated: false)
    
    birthdayTextField.inputAccessoryView = toolbar
    birthdayTextField.inputView = datePicker
  }
  
  func setupImagePickerController() {
    //imagePicker.modalPresentationStyle = .fullScreen // in ios 13 default presentation is page sheet
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
  }
  
  // MARK: - Actions
  
  @objc
  func changePhotoButtonTapped() {
    guard photoImageView.image == .defaultPhoto else {
      Alert.shared.changePhoto(in: self) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .change:
          self.present(self.imagePicker, animated: true, completion: nil)
        case .delete:
          self.photoImageView.image = .defaultPhoto
          self.changePhotoButton.setTitle("Добавить фото", for: .normal)
        }
      }
      
      return
    }
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  @objc
  func datePickerCancelButtonTapped() {
    view.endEditing(true)
  }
  
  @objc
  func datePickerDoneButtonTapped() {
    birthdayTextField.text = Format.shared.dateFormatter.string(from: datePicker.date)
    view.endEditing(true)
  }
  
  @objc
  func changeContactButtonTapped() {
    guard let role = role else { return }
    
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
      let contactViewModel = contactViewModel else {
        Alert.shared.error(in: self, message: "Что-то пошло не так")
        return
    }
    
    // storage key
    guard let key = key(for: contactViewModel.contact, or: phone) else {
      Alert.shared.error(in: self, message: "Что-то пошло не так")
      return
    }
    
    var checkPhoneUniqueness = false
    switch role {
    case .edit:
      // check only if the phone is changed
      if Format.shared.clear(phone: phone) != key {
        checkPhoneUniqueness = true
      }
    case .add:
      checkPhoneUniqueness = true
    }
    
    let updatedContact: Contact
    switch contactViewModel.contact {
    case .colleague:
      // colleague phone uniqueness check;
      if checkPhoneUniqueness,
        let _ = contactViewModel.exists(with: Format.shared.clear(phone: phone)) {
        Alert.shared.error(in: self, message: "Контакт (коллега) с таким номером уже существует!")
        return
      }
      
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
                                position: position,
                                key: key)
      
      updatedContact = .colleague(ColleagueViewModel(colleague: colleague))
    case .friend:
      // friend phone uniqueness check
      if checkPhoneUniqueness,
        let _ = contactViewModel.exists(with: phone) {
        Alert.shared.error(in: self, message: "Контакт (друг) с таким номером уже существует!")
        return
      }
      
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
                          birthday: birthday,
                          key: key)
      
      updatedContact = .friend(FriendViewModel(friend: friend))
    }
    let updatedContactViewModel = ContactViewModel(contact: updatedContact)
    
    switch role {
    case .edit:
      guard let idx = idx else { return }
      vc.updateContact(updatedContactViewModel, in: idx)
    case .add:
      vc.addContact(updatedContactViewModel)
    }
    
    navigationController?.popViewController(animated: true)
  }
  
}

// MARK: - UITextFieldDelegate

extension ContactViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    // process on filled
    if let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty,
      let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty,
      let _ = middleNameTextField.text?.trimmingCharacters(in: .whitespaces),
      let phone = phoneTextField.text?.trimmingCharacters(in: .whitespaces), !phone.isEmpty,
      let contact = contactViewModel?.contact {
      var fillDone = false
      switch contact {
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
        changeContactButtonTapped()
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
      guard let contact = contactViewModel?.contact else { return false }
      switch contact {
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

extension ContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      photoImageView.image = image
      
      changePhotoButton.setTitle("Изменить фото", for: .normal)
    }
    
    picker.dismiss(animated: true)
  }
  
}

// MARK: - Helpers

extension ContactViewController {
  
  // storage key
  func key(for contact: Contact, or phone: String) -> String? {
    guard let role = role else { return nil }
    switch role {
    case .edit:
      switch contact {
      case .colleague(let colleague):
        guard let colleague = colleague else { return nil }
        return colleague.key
      case .friend(let friend):
        guard let friend = friend else { return nil }
        return friend.key
      }
    case .add:
      return phone
    }
  }

}
