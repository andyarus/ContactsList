//
//  DatabaseServiceProtocol.swift
//  ContactList
//
//  Created by Andrei Coder on 18/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import Foundation

protocol DatabaseServiceProtocol {
  func createData(for entity: Entity)
  func retrieveData(all entity: Entity) -> [Entity]
  func retrieveData(by key: String, one entity: Entity) -> Entity?
  func updateData(by key: String, with entity: Entity)
  func deleteData(by key: String, for entity: Entity)
  func deleteData(all entity: Entity)
}
