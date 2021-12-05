//
//  MapView.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import SwiftUI
import ComposableArchitecture

struct MapView: View {
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      Image("SF_Map")
        .resizable()
        .scaledToFill()
    }
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
      MapView(store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
      )
    }
}
