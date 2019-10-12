//
//  ContactCell.swift
//  ContactList
//
//  Created by Andrei Coder on 13/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
  
  static let reuseIdentifier = "ContactCell"
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addSubviews() {
    self.addSubview(nameLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
      ])
  }
  
}
