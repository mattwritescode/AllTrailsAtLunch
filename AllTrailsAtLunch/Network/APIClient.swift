//
//  APIClient.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import Foundation
import Combine

public struct APIClient {
  public var baseURL: String
  public var apiKey: String

  public func restaurants(
    searchText: String,
    latitude: String = "29.951065",
    longitude: String = "-90.071533"
  ) -> AnyPublisher<[Result], Error> {
    let search = GooglePlacesNearbySearchManager (
      baseURL: self.baseURL,
      apiKey: self.apiKey,
      searchText: searchText,
      latitude: latitude,
      longitude: longitude
    )
    return search.fetch()

  }

  public init(baseURL: String, apiKey: String){
    self.baseURL = baseURL
    self.apiKey = apiKey
  }

  public static var live:  APIClient {
    return APIClient(
      baseURL: "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
      apiKey: "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"
    )
  }
}

#if DEBUG
extension APIClient {
  public static var mock:  APIClient {
    return APIClient(
      baseURL: "https://example.com/api/v3",
      apiKey: "3xpo"
    )
  }
}
#endif

