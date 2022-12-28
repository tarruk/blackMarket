//
//  User.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation

struct User: Codable {
  let email: String
  let name: String
  let url: String
  let nickname: String
  let profilePicture: String
  let birthDate: String
  let notificationsEnabled: Bool
  
  enum CodingKeys: String, CodingKey {
    case email
    case name
    case url
    case nickname
    case profilePicture = "profile_picture"
    case birthDate = "birth_date"
    case notificationsEnabled = "notifications_enabled"
  }
}
