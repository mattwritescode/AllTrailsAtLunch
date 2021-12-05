//
//  SearchBar.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//
import SwiftUI
import ComposableArchitecture

struct SearchBar: View {
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        TextField(
          "Search for a restaurant",
          text: viewStore.binding(
            get: { $0.searchText },
            send: { .didTypeSearch($0) }
          )
        )
          .disableAutocorrection(true)
          .padding(.horizontal, 10)
          .padding(8)
          .boxStyle()

      }
      .overlay(
        HStack {
          Image(systemName: "SearchIcon")
            .foregroundColor(.green)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)

          if viewStore.state.searchText.count > 0 {
            Button(action: {
              viewStore.send(.didTypeSearch(""))
            }) {
              Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
            }
          }
        }
      )
    }
  }
  
  struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
      SearchBar(store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
      )
    }
  }
}
