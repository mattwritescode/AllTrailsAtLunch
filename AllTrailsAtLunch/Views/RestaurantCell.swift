//
//  RestaurantCell.swift
//  AllTrailsAtLunch
//
//  Created by Matthew Tyler on 12/4/21.
//

import SwiftUI
import ComposableArchitecture

struct RestaurantCell: View {
  let index: Int
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack(alignment: .top){
        Image("martis-trail")
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
        Spacer()
        VStack(alignment: .leading ){
          Text(viewStore.places[index].name)
          HStack(alignment: .top){
            Stars(index: index, store: store)
            Text("(" + String(viewStore.places[index].numReviews) + ")")
          }
          Text(viewStore.places[index].priceIndex.rawValue + " • " + viewStore.places[index].supportingText)
            .font(.system(size: 12))
        }.frame(minWidth: 160, idealWidth: 200)
        Spacer()
        FavoriteButton(index: index, store: store)

      }
      .frame(maxWidth: .infinity, maxHeight: 80)
      .padding(16)
      .background(.white)
      .boxStyle()
//      .background(Color(.systemGray6))
    }
  }
}

struct FavoriteButton: View {
  let index: Int
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button(action: {
        viewStore.send(.didTapFavoriteButton(index))
      }
      ){
        Image(viewStore.state.places[index].isFavorite ? "Favorite" : "Favorite_deselected")
      }
    }
  }
}

struct Stars: View {
  let index: Int
  var store: Store<ContentStore.State, ContentStore.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        Image("Star_filled")
        Image(viewStore.places[index].rating.rawValue >= 2 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[index].rating.rawValue >= 3 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[index].rating.rawValue >= 4 ? "Star_filled" : "Star_gray")
        Image(viewStore.places[index].rating.rawValue == 5 ? "Star_filled" : "Star_gray")
      }
    }
  }
}

struct RestaurantCell_Previews: PreviewProvider {
  static var previews: some View {
    RestaurantCell(
      index: 0,
      store: .init(
        initialState: .mock,
        reducer: ContentStore.reducer,
        environment: .mock
      )
    )
  }
}
