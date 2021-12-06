//
//  Restaurant.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import Foundation

public struct Restaurant: Equatable, Identifiable {
  public let id: UUID
  public var name: String
  public var rating: Rating
  public var numReviews: Int
  public var priceIndex: PriceIndex
  public var supportingText: String
  public var isFavorite: Bool
}

public enum Rating: Int {
  case one = 1
  case two = 2
  case three = 3
  case four = 4
  case five = 5
}

public enum PriceIndex: String {
  case cheap = "$"
  case mid = "$$"
  case expensive = "$$$"
}

#if DEBUG
extension Restaurant{
  public static let mock = Restaurant(
    id: UUID(),
    name: "Test-aurant",
    rating: .three,
    numReviews: 135,
    priceIndex: .mid,
    supportingText: "Supporting Text",
    isFavorite: false
  )
  public static let favoriteMock = Restaurant(
    id: UUID(),
    name: "My Favorite Test-aurant",
    rating: .three,
    numReviews: 135,
    priceIndex: .mid,
    supportingText: "Supporting Text",
    isFavorite: true
  )
}
#endif
