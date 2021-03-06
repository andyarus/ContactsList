//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Andrei Coder on 12/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
  
  // MARK: - Properties
  
  private var contacts = Contacts()
  
  private var isColleagues: Bool = true {
    willSet(colleagues) {
      if colleagues {
        colleaguesButton.backgroundColor = .checked
        friendsButton.backgroundColor = .unchecked
      } else {
        colleaguesButton.backgroundColor = .unchecked
        friendsButton.backgroundColor = .checked
      }
    }    
    didSet {
      tableView.reloadData()
    }
  }
  
  let colleaguesButton = UIButton()
  let friendsButton = UIButton()
  let tableView = UITableView()
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    load()
  }
  
  // MARK: - Setup Methods
  
  func setup() {
    view.backgroundColor = .white
    
    setupNavigationBar()
    setupButtons()
    setupTableView()
    setupConstraints()
  }
  
  func setupNavigationBar() {
    navigationItem.title = "Контакты"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
  }
  
  func setupButtons() {
    colleaguesButton.setTitle("Коллеги", for: .normal)
    colleaguesButton.setTitleColor(.black, for: .normal)
    colleaguesButton.layer.cornerRadius = 4.0
    colleaguesButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colleaguesButtonTapped)))
    
    friendsButton.setTitle("Друзья", for: .normal)
    friendsButton.setTitleColor(.black, for: .normal)
    friendsButton.layer.cornerRadius = 4.0
    friendsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(friendsButtonTapped)))
  }
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    tableView.rowHeight = 69.0

    // TODO iPad customization: UIDevice.isIPad ? :
    //tableView.rowHeight = UIDevice.isIPad ? 169.0 : 69.0
  }
  
  func setupConstraints() {
    view.addSubview(colleaguesButton)
    view.addSubview(friendsButton)
    view.addSubview(tableView)
    
    colleaguesButton.translatesAutoresizingMaskIntoConstraints = false
    friendsButton.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    // TODO iPad customization: UIDevice.isIPad ? :
    // add different sizes
    
    NSLayoutConstraint.activate([
      colleaguesButton.heightAnchor.constraint(equalToConstant: 40),
      colleaguesButton.widthAnchor.constraint(equalToConstant: 80),
      colleaguesButton.trailingAnchor.constraint(equalTo: view.centerXAnchor),
      colleaguesButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10.0),
      
      friendsButton.heightAnchor.constraint(equalToConstant: 40),
      friendsButton.widthAnchor.constraint(equalToConstant: 80),
      friendsButton.leadingAnchor.constraint(equalTo: view.centerXAnchor),
      friendsButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10.0),
      
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
  }
  
  // MARK: - Load Methods
  
  func load() {
    isColleagues = true // colleaguesButtonTapped()
  }
  
  // MARK: - Actions
  
  @objc
  func colleaguesButtonTapped() {
    guard isColleagues != true else { return } // don't reload tableView
    isColleagues = true
  }
  
  @objc
  func friendsButtonTapped() {
    guard isColleagues != false else { return } // don't reload tableView
    isColleagues = false
  }
  
  @objc
  func addContactButtonTapped() {
    let vc = ContactViewController()
    vc.role = .add
    
    if isColleagues {
      vc.contactViewModel = ContactViewModel(contact: .colleague(nil))
    } else {
      vc.contactViewModel = ContactViewModel(contact: .friend(nil))
    }
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = ContactViewController()
    vc.role = .edit
    
    if isColleagues {
      vc.contactViewModel = ContactViewModel(contact: .colleague(contacts.colleagues[indexPath.row]))
    } else {
      vc.contactViewModel = ContactViewModel(contact: .friend(contacts.friends[indexPath.row]))
    }
    vc.idx = indexPath.row
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK: - UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isColleagues ? contacts.colleagues.count : contacts.friends.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier) as! ContactCell
    
    if isColleagues {
      contacts.colleagues[indexPath.row].configure(cell)
    } else {
      contacts.friends[indexPath.row].configure(cell)
    }
    
    return cell
  }
  
}

// MARK: - Helpers

extension ContactsViewController {
  
  func updateContact(_ contactViewModel: ContactViewModel, in idx: Int) {
    
    // update in storage
    contacts.update(contactViewModel.contact)
    
    switch contactViewModel.contact {
    case .colleague(let colleague):
      guard var colleague = colleague else { return }
      
      // update in storage must be first
      let phone = Format.shared.clear(phone: colleague.phone)
      if colleague.key != phone {
        colleague.key = phone
      }
      
      contacts.colleagues[idx] = colleague      
    case .friend(let friend):
      guard var friend = friend else { return }
      
      // update in storage must be first
      let phone = Format.shared.clear(phone: friend.phone)
      if friend.key != phone {
        friend.key = phone
      }
      
      contacts.friends[idx] = friend
    }
    
    tableView.reloadData()
  }
  
  func addContact(_ contactViewModel: ContactViewModel) {
    switch contactViewModel.contact {
    case .colleague(let colleague):
      guard let colleague = colleague else { return }
      contacts.colleagues.append(colleague)
      contacts.colleagues.sort(by: <)
    case .friend(let friend):
      guard let friend = friend else { return }
      contacts.friends.append(friend)
      contacts.friends.sort(by: <)
    }
    
    // write to storage
    contacts.add(contactViewModel.contact)
    
    tableView.reloadData()
  }
  
}
