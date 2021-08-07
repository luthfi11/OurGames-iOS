//
//  FavoriteView.swift
//  OurGames
//
//  Created by Dans Multipro on 01/08/21.
//

import SwiftUI

struct FavoriteView: View {
  let persistenceController: PersistenceController
  @State private var games: [Games] = [Games]()

  private func populateGames() {
    games = persistenceController.getGames()
  }

  var body: some View {
    NavigationView {
      ScrollView {
        if games.isEmpty {
          Text("Favorite games unavailable")
            .padding(20)
        } else {
          ForEach(games) { game in
            let gameData = Game(
              id: Int(game.id),
              name: game.name ?? "",
              released: game.released,
              backgroundImage: game.backgroundImage,
              rating: game.rating,
              ratingsCount: Int(game.ratingsCount),
              website: "",
              description: ""
            )
            NavigationLink(destination: GameDetailView(persistenceController: persistenceController, id: Int(game.id))) {
              GameRow(game: gameData)
            }
          }
        }
      }
      .navigationBarTitle("Favorite", displayMode: .inline)
      .onAppear {
        populateGames()
      }
    }
  }
  
  struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
      FavoriteView(persistenceController: PersistenceController())
    }
  }
}
