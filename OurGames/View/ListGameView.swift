//
//  ListGameView.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import SwiftUI

struct ListGameView: View {
  @ObservedObject var gameViewModel = GamesViewModel()
  private var gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  var body: some View {
    NavigationView {
      ScrollView {
        if gameViewModel.isLoading {
          ProgressView()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        } else {
          LazyVGrid(columns: gridItem) {
            ForEach(gameViewModel.gameList.results, id: \.id) { game in
              NavigationLink(destination: GameDetailView(id: game.id)) {
                GameGrid(game: game)
              }
            }
          }
          .padding(10)
        }
      }
      .navigationBarTitle("Home", displayMode: .inline)
      .onAppear {
        self.gameViewModel.getGames(query: "")
      }
    }
  }
}

struct ListGameView_Previews: PreviewProvider {
  static var previews: some View {
    ListGameView()
  }
}
