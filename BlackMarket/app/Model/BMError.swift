//
//  BMError.swift
//  BlackMarket
//
//  Created by Tarek Radovan on 13/02/2023.
//

import Foundation
import RSSwiftNetworking
import Alamofire

public enum BMErrorCode: Error {
  case badResult
  
  var localizedError: String {
    switch self {
    case .badResult:
      return "Bad result"
    }
  }
}

public struct BMAPIError: Decodable, Error {
  var detail: String?
  var code: String?
  var messages: [BMErrorMessage]?
  var internalCode: BMErrorCode?
  var nonFieldErrors: [String]?
  
  enum CodingKeys: String, CodingKey {
    case detail
    case code
    case messages
    case nonFieldErrors = "non_field_errors"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
    self.code = try container.decodeIfPresent(String.self, forKey: .code)
    self.messages = try container.decodeIfPresent([BMErrorMessage].self, forKey: .messages)
    self.nonFieldErrors = try container.decodeIfPresent([String].self, forKey: .nonFieldErrors)
  }
  
  init(code: BMErrorCode?) {
    self.internalCode = code
  }
  
  init(_ error: Error) {
    detail = error.localizedDescription
  }
  
  func getMessage() -> String? {
    if let internalCode = internalCode {
      return internalCode.localizedError
    }
    if let firstError = messages?.first {
      return firstError.message
    }
    if let nonFieldError = nonFieldErrors?.first {
      return nonFieldError
    }
    if let defaultError = detail {
      return defaultError
    }
    return nil
  }
}

struct BMErrorMessage: Decodable {
  let tokenClass: String
  let tokenType: String
  let message: String
  
  enum CodingKeys: String, CodingKey {
    case tokenClass = "token_class"
    case tokenType = "token_type"
    case message
  }
}

public struct BMError: LocalizedError {
  let error: BMAPIError
  
  public init?(
    response: Network.Response,
    decodingConfiguration: DecodingConfiguration
  ) {
    let decoder = JSONDecoder(decodingConfig: decodingConfiguration)
    guard
      let data = response.data,
      let decodedError = try? decoder.decode(BMAPIError.self, from: data)
    else {
      return nil
    }
    error = decodedError
  }
  
  public init(code: BMErrorCode) {
    error = BMAPIError(code: BMErrorCode.badResult)
  }
  
  public init(_ error: Error) {
    self.error = BMAPIError(error)
  }
  
  public var errorDescription: String? {
    error.getMessage()
  }
}
