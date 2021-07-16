//
//  GameRow.swift
//  OurGames
//
//  Created by Dans Multipro on 16/07/21.
//

import SwiftUI
import URLImage

struct GameRow: View {
  var game: Game
  
  var body: some View {
    HStack {
      if ((game.background_image) != nil) {
        URLImage(URL(string: game.background_image ?? "")!) {
          EmptyView()
        } inProgress: { _ in
          Color.gray
            .frame(width: 70, height: 70)
            .cornerRadius(8)
        } failure: { _, _ in
          Color.gray
            .frame(width: 70, height: 70)
            .cornerRadius(8)
        } content: { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 70, alignment: .center)
            .clipped()
            .cornerRadius(8)
        }
      } else {
        Color.gray
          .frame(width: 70, height: 70)
          .cornerRadius(8)
      }
      
      VStack(alignment: .leading) {
        Text(game.name)
          .padding(.horizontal, 10)
          .foregroundColor(.red)
        Text(game.released ?? "-")
          .padding(.horizontal, 10)
          .foregroundColor(.gray)
          .font(.caption)
      }
      
      Spacer()
      HStack {
        Text(String(game.rating ?? 0))
          .font(.system(size: 13))
          .foregroundColor(.yellow)
      }
      .padding(.vertical, 5)
      .frame(width: 70)
      .background(Color.black)
      .cornerRadius(20)
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      alignment: .leading
    )
    .padding(10)
  }
}

struct GameRow_Previews: PreviewProvider {
  static let game = Game(
    id: 1,
    name: "FIFA 2020",
    released: "01-01-2020",
    background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
    rating: 4.5,
    ratings_count: 1234
  )
  
  static var previews: some View {
    GameRow(game: game)
  }
}
