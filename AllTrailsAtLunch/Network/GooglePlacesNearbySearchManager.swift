//
//  GooglePlacesNearbySearch.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/5/21.
//

import Foundation
import Combine
import ComposableArchitecture


/// https://developers.google.com/maps/documentation/places/web-service/search-nearby
struct GooglePlacesNearbySearchManager {
  var request: URLRequest

  init(baseURL: String,
       apiKey: String,
       searchText: String,
       latitude: String,
       longitude: String,
       radius: String = "5000",
       type: String = "restaurant"
  ) {
    var components = URLComponents(string: baseURL)

    components?.queryItems = [
      URLQueryItem(name: "location", value: latitude + "," + longitude),
      URLQueryItem(name: "type", value: type),
      URLQueryItem(name: "key", value: apiKey),
      URLQueryItem(name: "radius", value: radius)
    ]
    if searchText != "" {
      components?.queryItems?.append(URLQueryItem(name: "keyword", value: searchText))
    }

    guard let url = components?.url else {
      fatalError("\(baseURL) is not a valid URL string")
    }

    self.request = URLRequest(url: url)
  }


  public func fetch() -> AnyPublisher<[Result], Error> {
    return URLSession.DataTaskPublisher(request: request, session: .shared)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
              }
        return element.data
      }
      .decode(type: GooglePlacesNearbySearchModel.self, decoder: JSONDecoder())
      .map(\.results)
      .eraseToAnyPublisher()
  }
}
//
//public func fetch() -> AnyPublisher<[Restaurant], Error> {
//
//  return URLSession.DataTaskPublisher(request: request, session: .shared)
//    .tryMap() { element -> Data in
//      guard let httpResponse = element.response as? HTTPURLResponse,
//            httpResponse.statusCode == 200 else {
//              throw URLError(.badServerResponse)
//            }
//      return element.data
//    }
//    .decode(type: GooglePlacesNearbySearchModel.self, decoder: JSONDecoder())
//    .map(\.results)
//    .map{ results in
//      var restaurants: [Restaurant] = []
//      for result in results {
//        restaurants.append(Restaurant(result: result))
//      }
//      return restaurants
//    }
//    .eraseToAnyPublisher()
//}
//}
