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
  
  private var isColleagues: Bool = true {
    willSet(colleagues) {
      if colleagues {
        colleaguesButton.backgroundColor = .orange
        friendsButton.backgroundColor = .white
        tableView.reloadData()
      } else {
        colleaguesButton.backgroundColor = .white
        friendsButton.backgroundColor = .orange
        tableView.reloadData()
      }
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
  }
  
  func setupConstraints() {
    view.addSubview(colleaguesButton)
    view.addSubview(friendsButton)
    view.addSubview(tableView)
    
    colleaguesButton.translatesAutoresizingMaskIntoConstraints = false
    friendsButton.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
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
    loadDefaultColleagues()
    loadDefaultFriends()
    
    isColleagues = true // tap
  }
  
  func loadDefaultColleagues() {
    colleagues = ColleagueViewModel.defaultColleagues()
  }
  
  func loadDefaultFriends() {
    friends = FriendViewModel.defaultFriends()
  }
  
  // MARK: - Tap Methods
  
  @objc
  func colleaguesButtonTapped() {
    isColleagues = true
  }
  
  @objc
  func friendsButtonTapped() {
    isColleagues = false
  }
  
}

// MARK: - UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isColleagues ? colleagues.count : friends.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier) as! ContactCell
    
    if isColleagues {
      colleagues[indexPath.row].configure(cell)
    } else {
      friends[indexPath.row].configure(cell)
    }
    
    return cell
  }
  
}

// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
  }
  
}
