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
  private var colleagues: [ColleagueViewModel] = []
  private var friends: [FriendViewModel] = []
  
  let tableView = UITableView()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    load()
  }
  
  // MARK: - Setup Methods
  func setup() {
    setupTableView()
  }
  
  func setupTableView() {
    tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    
    view.addSubview(tableView)
    
    //tableView.delegate = self
    tableView.dataSource = self
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
  }
  
  func load() {
    loadDefaultColleagues()
    loadDefaultFriends()
  }
  
  func loadDefaultColleagues() {
    let colleague = Colleague(firstName: "Вася1",
                              lastName: "Пупкин",
                              middleName: "Алибабаевич",
                              photo: UIImage(),
                              phone: "12345",
                              workPhone: "911",
                              positin: "менеджер")
    let colleagueViewModel = ColleagueViewModel(colleague: colleague)
    
    colleagues.append(colleagueViewModel)
  }
  
  func loadDefaultFriends() {
    let friend = Friend(firstName: "Вася2",
                              lastName: "Пупкин",
                              middleName: "Алибабаевич",
                              photo: UIImage(),
                              phone: "12345",
                              birthday: Date())
    let friendViewModel = FriendViewModel(friend: friend)
    
    friends.append(friendViewModel)
  }
  
}

extension ContactsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colleagues.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier) as! ContactCell
    
    let contact = colleagues[indexPath.row]
    cell.nameLabel.text = "\(contact.lastName) \(contact.firstName) \(contact.middleName ?? "")"
    
    return cell
  }
  
}
