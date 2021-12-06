//
//  RestaurantCell.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/4/21.
//

import SwiftUI
import ComposableArchitecture

struct RestaurantCell: View {
  let id: Restaurant.ID
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack(alignment: .top){
        Image("martis-trail")
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
        Spacer()
        VStack(alignment: .leading ){
          Text(viewStore.places[id: id]?.name)
          HStack(alignment: .top){
            Stars(id: id, store: store)
            Text("(" + String(viewStore.places[id: id]?.numReviews) + ")")
          }
          Text(viewStore.places[id: id]?.priceIndex.rawValue + " • " + viewStore.places[id: id]?.supportingText)
            .font(.system(size: 12))
        }.frame(minWidth: 160, idealWidth: 200)
        Spacer()
        FavoriteButton(id: id, store: store)

      }
      .frame(maxWidth: .infinity, maxHeight: 80)
      .padding(16)
      .background(.white)
      .boxStyle()
    }
  }
}

struct FavoriteButton: View {
  let id: Restaurant.ID
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button(action: {
        viewStore.send(.didTapFavoriteButton(id))
      }
      ){
        Image(viewStore.state.places[id: id]?.isFavorite ? "Favorite" : "Favorite_deselected")
      }
    }
  }
}

struct Stars: View {
  let id: Restaurant.ID
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        Image("Star_filled")
        Image(viewStore.places[id: id]?.rating.rawValue >= 2 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[id: id]?.rating.rawValue >= 3 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[id: id]?.rating.rawValue >= 4 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[id: id]?.rating.rawValue == 5 ? "Star_filled" : "Star_gray")
      }
    }
  }
}

struct RestaurantCell_Previews: PreviewProvider {
  static var previews: some View {
    RestaurantCell(
      id: 0,
      store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
    )
  }
}
