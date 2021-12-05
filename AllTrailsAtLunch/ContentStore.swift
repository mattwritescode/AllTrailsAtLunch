//
//  RestaurantStore.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import ComposableArchitecture
import SwiftUI

public enum ContentStore {

  public struct State: Equatable {
    var places: [Restaurant]
    var currentView: ViewType
    var searchText: String
  }

  public enum Action: Equatable {
    case didTapListButton
    case didTypeSearch(String)
    case receivedResponseFromGoogle
    case didTapFavoriteButton(Int)
  }

  public static let reducer: Reducer<State, Action, Environment> = .combine(
    Reducer { state, action, _ in
      switch action {
      case .didTapListButton:
        return .none
      case .didTypeSearch( let searchText):
        // debounce 2 seconds
        // network call to google places
        return .none
      case .receivedResponseFromGoogle:
        // update places
        return .none
      case .didTapFavoriteButton(let index):
        state.places[index].isFavorite.toggle()
        return .none
      }
    }
  )
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

