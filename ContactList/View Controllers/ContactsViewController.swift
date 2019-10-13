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
    tableView.dataSource = self
    tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    tableView.rowHeight = 69.0
    
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
  }
  
  // MARK: - Load Methods
  
  func load() {
    loadDefaultColleagues()
    loadDefaultFriends()
  }
  
  func loadDefaultColleagues() {
    colleagues = ColleagueViewModel.defaultColleagues()
  }
  
  func loadDefaultFriends() {
    friends = FriendViewModel.defaultFriends()
  }
  
}

// MARK: - UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colleagues.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier) as! ContactCell
    
    let contact = colleagues[indexPath.row]
    cell.photoImageView.image = contact.photo
    cell.nameLabel.text = "\(contact.lastName) \(contact.firstName) \(contact.middleName ?? "")"
    
    return cell
  }
  
}
