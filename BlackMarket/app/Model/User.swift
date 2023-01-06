//
//  User.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 23/12/2022.
//

import Foundation

struct UserResponse: Decodable {
  let accessToken: String
  let refreshToken: String
  let user: User
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case user
  }
}

struct User: Codable {
  let pk: Int?
  let email: String?
  let firstName: String?
  let lastName: String?
  let url: String?
  let nickname: String?
  let profilePicture: String?
  let birthDate: String?
  let notificationsEnabled: Bool?
  
  
  enum CodingKeys: String, CodingKey {
    case pk
    case email
    case firstName = "first_name"
    case lastName = "last_name"
    case url
    case nickname
    case profilePicture = "profile_picture"
    case birthDate = "birth_date"
    case notificationsEnabled = "notifications_enabled"
  }
}
