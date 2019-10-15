//
//  TextField.swift
//  ContactList
//
//  Created by Andrei Coder on 14/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit

class TextField: UITextField {
  
  let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.cornerRadius = 4.0    
    clearButtonMode = .whileEditing
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
}
