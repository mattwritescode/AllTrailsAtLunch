//
//  ListView.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import SwiftUI
import ComposableArchitecture

struct ListView: View {
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      List(viewStore.places) { place in
        RestaurantCell(place: place, store: store)
          .listRowSeparator(.hidden)
          .listRowBackground(Color(.systemGray6))
      }.frame(alignment: .center)
      .listStyle(.insetGrouped)
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView(store: .init(
      initialState: .mock,
      reducer: ContentStore.reducer,
      environment: .mock
    )
    )
  }
}
