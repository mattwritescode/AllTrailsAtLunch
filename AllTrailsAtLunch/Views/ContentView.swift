//
//  ContentView.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  public var store: Store<ContentStore.State, ContentStore.Action>

  public init(
    store: Store<ContentStore.State, ContentStore.Action>
  ) {
    self.store = store
  }
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(alignment: .center) {
        HeaderView(store: store)
        switch viewStore.currentView {
        case .map:
          MapView(store: store)
        case .list:
          ListView(store: store)
        }
      }.onAppear{
        viewStore.send(.onAppStart)
      }
    }
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: .init(
      initialState: .mockMap,
      reducer: ContentStore.reducer,
      environment: .mock
    )
    )
  }
}
