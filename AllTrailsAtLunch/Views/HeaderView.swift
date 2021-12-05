//
//  HeaderView.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/3/21.
//

import SwiftUI
import ComposableArchitecture

struct HeaderView: View {
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        Spacer()
        HStack {
          Image("Logo")
          Text("AllTrails")
            .foregroundColor(Color(.systemGray))
            .font(.system(size: 24, weight: .semibold ))
          Text("at Lunch")
            .foregroundColor(Color(.systemGray4))
            .font(.system(size: 24, weight: .light))
        }
        Spacer(minLength: 8)
        HStack {
          Button("Filter") {
            // stretch goal
          }.foregroundColor(.gray)
            .padding(8)
            .boxStyle()
          Spacer(minLength: 8)
          SearchBar(store: store)
        }.padding(.horizontal, 24)
      }.padding(.vertical, 16)
        .frame(minWidth: 300, idealWidth: 375, maxWidth: .infinity, minHeight: 100, idealHeight: 134, maxHeight: 134, alignment: .center)
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(store: .init(
      initialState: .mock,
      reducer: ContentStore.reducer,
      environment: .mock
    )
    )
  }
}
