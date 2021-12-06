//
//  Restaurant+Results.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/5/21.
//

import Foundation
extension Restaurant {
  public init(result: Result) {
    self.id = UUID()
    self.name = result.name
    self.rating = Rating(result.rating)
    self.numReviews = result.userRatingsTotal
    self.priceIndex = PriceIndex(result.priceLevel)
    //TODO: find better supporting text, this seems to be the other human readable bit besides the name
    self.supportingText = result.vicinity
    self.isFavorite = false
  }
}

extension Rating {
  public init(_ value: Double) {
    switch value {
    case 0..<1:
      self = .one
    case 1..<2:
      self = .two
    case 2..<3:
      self = .three
    case 3..<4:
      self = .four
    case 4..<5:
      self = .five
    default:
      fatalError("rating should always be 0 to 5")
    }
  }
}

extension PriceIndex {
  public init(_ value: Int?) {
    switch value {
    case 1:
      self = .cheap
    case 2:
      self = .mid
    case 3:
      self = .expensive
    default:
      print("PriceIndex had nil value, setting to mid for now.")
      self = .mid
    }
  }
}
