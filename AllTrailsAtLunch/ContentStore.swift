//
//  RestaurantStore.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import ComposableArchitecture
import SwiftUI
import CoreLocation

public enum ContentStore {

  public struct State: Equatable {
    var places: IdentifiedArrayOf<Restaurant>
    var currentView: ViewType
    var searchText: String
    var locManager = LocationManager()

    public static let live = ContentStore.State(
      places: [],
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

        // get location
        // trigger google search

        return Effect(value: .requestFromGoogle)
      case .didTapListMapButton:
        if state.currentView == .list {
          state.currentView = .map
        } else {
          state.currentView = .list
        }
        return .none

      case .didTypeSearch(let searchText):
        // TODO: debounce 2 seconds
        // network call to google places
        state.searchText = searchText
        return Effect(value: .requestFromGoogle)

      case .requestFromGoogle:
        print("MATT",state.searchText, state.locManager.latitude, state.locManager.longitude)
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
          
          var restaurants: [Restaurant] = []
          for result in results {
            state.places.append(Restaurant(result: result))
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
  ).debug()

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

