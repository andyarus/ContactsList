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
    addSubview(photoImageView)
    addSubview(nameLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 46.0),
      photoImageView.heightAnchor.constraint(equalToConstant: 46.0),
      photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
      photoImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -10.0),
      
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
      ])
  }
  
}
