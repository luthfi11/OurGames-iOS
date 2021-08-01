//
//  GameGrid.swift
//  OurGames
//
//  Created by Dans Multipro on 11/07/21.
//

import SwiftUI
import URLImage

struct GameGrid: View {
  var game: Game
  
  var body: some View {
    VStack(alignment: .leading) {
      if game.backgroundImage != nil {
        URLImage(URL(string: game.backgroundImage ?? "")!) {
          EmptyView()
        } inProgress: { _ in
          Color.gray
          .frame(maxWidth: .infinity)
          .frame(height: 100)
        } failure: { _, _ in
          Color.gray
          .frame(maxWidth: .infinity)
          .frame(height: 100)
        } content: { image in
          image
            .resizable()
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .aspectRatio(contentMode: .fit)
        }
      }
      HStack {
        Image(systemName: "star.fill")
          .foregroundColor(.yellow)
        Text(String(game.rating ?? 0))
          .font(.subheadline)
          .foregroundColor(.yellow)
      }
      .padding(5)
      .background(Color.black)
      .offset(y: -38)
      
      Text(game.name)
        .padding(.horizontal, 10)
        .offset(y: -30)
      Text(game.released ?? "-")
        .padding(.horizontal, 10)
        .foregroundColor(.gray)
        .font(.caption)
        .offset(y: -30)
    }
    .frame(height: 170, alignment: .top)
    .cornerRadius(8)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.gray, lineWidth: 0.2)
    )
    .padding(.top, 10)
    .padding(.horizontal, 5)
  }
}

struct GameGrid_Previews: PreviewProvider {
  static let game = Game(
    id: 1,
    name: "FIFA 2020",
    released: "01-01-2020",
    backgroundImage: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
    rating: 4.5,
    ratingsCount: 1234,
    website: "",
    description: ""
  )
  
  static var previews: some View {
    GameGrid(game: game)
  }
}
