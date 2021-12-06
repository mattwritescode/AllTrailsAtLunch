//
//  RestaurantCell.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/4/21.
//

import SwiftUI
import ComposableArchitecture

struct RestaurantCell: View {
  let place: Restaurant
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack(alignment: .top){
        Image("martis-trail")
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
        Spacer()
        VStack(alignment: .leading ){
          Text(place.name)
          HStack(alignment: .top){
            Stars(place: place, store: store)
            Text("(" + String(place.numReviews) + ")")
          }
          Text(place.priceIndex.rawValue + " • " + place.supportingText)
            .font(.system(size: 12))
        }.frame(minWidth: 160, idealWidth: 200)
        Spacer()
        FavoriteButton(place: place, store: store)

      }
      .frame(maxWidth: .infinity, maxHeight: 80)
      .padding(16)
      .background(.white)
      .boxStyle()
    }
  }
}

struct FavoriteButton: View {
  let place: Restaurant
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button(action: {
        viewStore.send(.didTapFavoriteButton(place.id))
      }
      ){
        Image(place.isFavorite ? "Favorite" : "Favorite_deselected")
      }
    }
  }
}

struct Stars: View {
  let place: Restaurant
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        Image("Star_filled")
        Image(place.rating.rawValue >= 2 ? "Star_filled" : "Star_gray")
        Image(place.rating.rawValue >= 3 ? "Star_filled" : "Star_gray")
        Image(place.rating.rawValue >= 4 ? "Star_filled" : "Star_gray")
        Image(place.rating.rawValue == 5 ? "Star_filled" : "Star_gray")
      }
    }
  }
}

struct RestaurantCell_Previews: PreviewProvider {
  static var previews: some View {
    RestaurantCell(
      place: .mock,
      store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
    )
  }
}
