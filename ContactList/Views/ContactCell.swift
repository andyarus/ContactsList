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
  
  let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 23.0
    
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14)
    
    return label
  }()
  
  let phoneLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    
    return label
  }()
  
  let workPhoneLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    
    return label
  }()
  
  let infoLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    accessoryType = .disclosureIndicator
    
    addSubviews()
    setupConstraints()
  }
  
  func addSubviews() {
    addSubview(photoImageView)
    addSubview(nameLabel)
    addSubview(phoneLabel)
    addSubview(workPhoneLabel)
    addSubview(infoLabel)
  }
  
  func setupConstraints() {
    
    phoneLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    infoLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 46.0),
      photoImageView.heightAnchor.constraint(equalToConstant: 46.0),
      photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
      
      photoImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -8.0),
      photoImageView.trailingAnchor.constraint(equalTo: phoneLabel.leadingAnchor, constant: -8.0),
      photoImageView.trailingAnchor.constraint(equalTo: workPhoneLabel.leadingAnchor, constant: -8.0),
      
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
      nameLabel.bottomAnchor.constraint(equalTo: phoneLabel.topAnchor, constant: -1.0),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36.0),
      
      phoneLabel.bottomAnchor.constraint(equalTo: workPhoneLabel.topAnchor, constant: -1.0),
      phoneLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -4.0),
      
      workPhoneLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
      workPhoneLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -4.0),
      
      infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36.0)
      ])
  }
  
}
