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
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
  }
  
  func load() {
    
  }

}

