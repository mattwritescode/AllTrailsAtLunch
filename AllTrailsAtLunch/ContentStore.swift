//
//  RestaurantStore.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import ComposableArchitecture
import Combine
import SwiftUI
import CoreLocation

public enum ContentStore {

  public struct State: Equatable {
    var places: IdentifiedArrayOf<Restaurant>
    var currentView: ViewType
    var searchText: String
    var locManager = LocationManager()

    var cancellables = Set<AnyCancellable>()

    public static let live = ContentStore.State(
      places: IdentifiedArrayOf<Restaurant>(),
      currentView: .list,
      searchText: ""
    )
  }

  public enum Action {
    case onAppStart
    case didTapListMapButton
    case didTypeSearch(String)
    case requestFromGoogle
    case receivedResponseFromGoogle(
      Swift.Result<[Result], Error>
    )
    case didTapFavoriteButton(UUID)
  }

  public static let reducer: Reducer<State, Action, Environment> = .combine(
    Reducer { state, action, env in
      switch action {
      case .onAppStart:
        // if we get location authorization -> trigger google search
        return .merge(
          Effect(value: Action.requestFromGoogle),
          .run { [state] subscriber in
            return state.locManager.$lastLocation.sink(
              receiveValue: { location in
                if state.locManager.latitude != "0.0" {
                  
                  // update search after location found for the first time
                  subscriber.send(Action.requestFromGoogle)

                  // stop listening after the first time.
                  subscriber.send(completion: .finished)
                }
              })
          }
        )

      case .didTapListMapButton:
        if state.currentView == .list {
          state.currentView = .map
        } else {
          state.currentView = .list
        }
        return .none

      case .didTypeSearch(let searchText):
        state.searchText = searchText
        return  Effect(value: .requestFromGoogle)
          .throttle(for: 2.0, scheduler: env.mainQueue, latest: true)
          .eraseToEffect()

      case .requestFromGoogle:
        return env.apiClient.restaurants(
          searchText: state.searchText,
          latitude: state.locManager.latitude,
          longitude: state.locManager.longitude
        )
          .receive(on: env.mainQueue)
          .catchToEffect()
          .map(Action.receivedResponseFromGoogle)

      case .receivedResponseFromGoogle(let result):
        switch result {
        case .success(let results):

          // Convert to Restaurants for display to user
          var restaurants: IdentifiedArrayOf<Restaurant> = []
          for result in results {
            restaurants.append(Restaurant(result: result))
          }
          state.places = IdentifiedArrayOf<Restaurant>(uniqueElements: restaurants)

        case .failure(let error):
          print(error.localizedDescription)
        }
        return .none

      case .didTapFavoriteButton(let id):
        state.places[id: id]?.isFavorite.toggle()
        return .none
      }
    }
  )
  #if DEBUG
    .debug()
  #endif
}

enum ViewType {
  case map
  case list
}

#if DEBUG
extension ContentStore.State {
  public static let mock = ContentStore.State(places: [.mock, .mock, .mock, .mock, .mock], currentView: .list, searchText: "")
  public static let mockMap = ContentStore.State(places: [.mock, .mock, .mock, .mock, .mock], currentView: .map, searchText: "")
}
#endif

