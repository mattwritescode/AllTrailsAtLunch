//
//  AllTrailsAtLunchApp.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import SwiftUI

@main
struct AllTrailsAtLunchApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
      )
    }
  }
}
